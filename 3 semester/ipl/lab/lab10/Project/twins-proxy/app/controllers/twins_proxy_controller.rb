require 'net/http'
require 'nokogiri'

class TwinsProxyController < ApplicationController
  BASE_API_URL = 'http://127.0.0.1:3000/twins_api/view'.freeze # Путь до файла с возможностью преобразования
  XSLT_TRANSFORM = "#{Rails.root}/public/some_transformer.xslt".freeze # Путь до xslt файла

  def input; end

  def view
    print 'Params:', params, "\n"

    responce = make_query BASE_API_URL, '.xml'

    respond_to do |format|
      # http://127.0.0.1:3001/twins_proxy/view.html?n=10
      format.html do
        print 'Render HTML ', params[:commit], "\n"

        @output = xslt_transform(responce).to_html
      end

      # http://127.0.0.1:3001/twins_proxy/view.xml?n=10
      format.xml do
        print 'Render XML ', params[:commit], "\n"

        @output = insert_browser_xslt(responce).to_xml
      end

      # http://127.0.0.1:3001/twins_proxy/view.rss?n=10
      format.rss { render xml: insert_browser_xslt(responce).to_xml }
    end
  end

  def make_query(server_url, file_type = '')
    # server_url - URL для получения ответа от приложения 1 (API)
    # file_type - тип файла, по умолчанию .html

    query_str = server_url.to_s + file_type
    query_str << "?n=#{@input}" if (@input = params[:n]&.split(' ')&.join('+'))
    pp 'query_str:', query_str

    uri = URI(query_str)

    res = Net::HTTP.get_response(uri)

    if file_type != '.xml'
      # Форматируем html вывод
      str1_markerstring = '<span>' # маркер начала xml
      str2_markerstring = '</span>' # маркер конца xml
    else
      str1_markerstring = '<output>' # маркер начала xml
      str2_markerstring = '</output>' # маркер конца xml
    end

    output = res.body[/#{str1_markerstring}(.*?)#{str2_markerstring}/m, 1]
    output.gsub('&lt;', '<').gsub('&gt;', '>')
  end

  def xslt_transform(data, transform: XSLT_TRANSFORM)
    # Функция преобразования

    print data, transform, "\n"

    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XSLT(File.read(transform))
    xslt.transform(doc)
  end

  # Чтобы преобразование XSLT на клиенте работало, надо вставить ссылку на XSLT.
  # Делается это с помощью nokogiri через ProcessingInstruction (потому что ссылка
  # на XSLT называется в XML processing instruction).
  def insert_browser_xslt(data, transform: XSLT_TRANSFORM)
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XML::ProcessingInstruction.new(doc,
                                                    'xml-stylesheet',
                                                    "type=\"text/xsl\" href=\"#{transform}\"")
    doc.root.add_previous_sibling(xslt)
    # Возвращаем doc, так как предыдущая операция возвращает не XML-документ.
    doc
  end
end
