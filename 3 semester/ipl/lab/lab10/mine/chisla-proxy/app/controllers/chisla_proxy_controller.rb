require 'net/http'
require 'nokogiri'

class ChislaProxyController < ApplicationController
  BASE_API_URL = 'http://127.0.0.1:3000/chisla_api/view' # Путь до файла с возможность преобразования
  XSLT_SERVER_TRANSFORM = "#{Rails.root}/public/some_transformer.xslt" # Путь до xslt файла
  def input
  end

  def view
    responce = make_query BASE_API_URL, '.xml'
    respond_to do |format|
      format.html do
        print 'Render HTML ', params[:commit], "\n"
        if responce == 'Unknown!' || responce == "Something is wrong"
          @output = responce
        else
          @output = xslt_transform(responce).to_html
        end
      end
      format.xml do
        print 'Render XML ', params[:commit], "\n"
        if responce == ' Unknown! ' || responce == "\n" + "  Something is wrong\n"
          @output = '<catalog>' + responce + '</catalog>'
        else
          @output = insert_browser_xslt(responce).to_xml
        end
      end
      format.rss { render xml: insert_browser_xslt(responce).to_xml }
    end
  end

  def make_query(server_url, file_type = '')
    # server_url - URL для получения ответа от приложения 1 (API)

    query_str = server_url.to_s + file_type
    query_str << "?str=#{@input}" if (@input = params[:str]&.split(' ')&.join('+'))

    uri = URI(query_str)

    res = Net::HTTP.get_response(uri)

    # Форматируем html вывод
    if file_type != '.xml'
      # Форматируем html вывод
      str1_markerstring = '<span>' # маркер начала xml
      str2_markerstring = '</span>' # маркер конца xml
    else
      str1_markerstring = '<output>' # маркер начала xml
      str2_markerstring = '</output>' # маркер конца xml
    end
    output = res.body[/#{str1_markerstring}(.*?)#{str2_markerstring}/m, 1]
    output.gsub('&lt;', '<').gsub('&gt;', '>').strip
  end

  def xslt_transform(data, transform: XSLT_SERVER_TRANSFORM)
    # Функция преобразования
    print data, transform, "\n"
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XSLT(File.read(transform))
    xslt.transform(doc)
  end

  # Чтобы преобразование XSLT на клиенте работало, надо вставить ссылку на XSLT.
  # Делается это с помощью nokogiri через ProcessingInstruction (потому что ссылка
  # на XSLT называется в XML processing instruction).
  def insert_browser_xslt(data, transform: XSLT_SERVER_TRANSFORM)
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XML::ProcessingInstruction.new(doc,
                                                    'xml-stylesheet',
                                                    "type=\"text/xsl\" href=\"#{transform}\"")
    doc.root.add_previous_sibling(xslt)
    # Возвращаем doc, так как предыдущая операция возвращает не XML-документ.
    doc
  end
end
