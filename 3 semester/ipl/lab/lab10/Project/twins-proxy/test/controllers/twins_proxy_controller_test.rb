require 'test_helper'
require 'net/http'

class TwinsProxyControllerTest < ActionDispatch::IntegrationTest
  BASE_API_URL = 'http://127.0.0.1:3000/twins_api/view'.freeze # Путь до файла с возможностью преобразования

  test 'should get input' do
    get twins_proxy_input_url
    assert_response :success
  end

  test 'should get view' do
    get twins_proxy_view_url
    assert_response :success
  end

  test 'check different result' do
    get twins_proxy_view_url, params: { n: 3 }
    result1 = assigns[:output]

    get twins_proxy_view_url, params: { n: 10 }
    result2 = assigns[:output]

    assert_not_same result1, result2
  end

  test 'we check that the XML is unchanged' do
    query_str = "#{BASE_API_URL}.xml"
    query_str << '?n=10'
    uri = URI(query_str)
    res = Net::HTTP.get_response(uri)

    target = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<output>\n    &lt;catalog&gt;&lt;cd&gt;&lt;id&gt;11&lt;/id&gt;&lt;item&gt;13&lt;/item&gt;&lt;/cd&gt;&lt;cd&gt;&lt;id&gt;17&lt;/id&gt;&lt;item&gt;19&lt;/item&gt;&lt;/cd&gt;&lt;/catalog&gt;\n</output>\n"

    assert_equal target, res.body
  end

  test 'check html proxy result' do
    get twins_proxy_view_url, params: { n: 3 }
    result = assigns[:output]
    target = "<table border=\"1\">\n<tr bgcolor=\"#9933ff\">\n<th>1</th>\n<th>2</th>\n</tr>\n<tr>\n<td>3</td>\n<td>5</td>\n</tr>\n</table>\n"

    assert_equal result, target
  end

  test 'check xml proxy result' do
    get "#{twins_proxy_view_url}.xml", params: { n: 3 }
    target = "<?xml version=\"1.0\"?>\n<?xml-stylesheet type=\"text/xsl\" ?>\n<catalog>\n  <cd>\n    <id>3</id>\n    <item>5</item>\n  </cd>\n</catalog>\n"
    # убираем href, т.к. зависит от системы
    actual = assigns[:output].gsub(/href=.*.xslt"/, '')

    assert_equal actual, target
  end

  test 'check rss' do
    get "#{twins_proxy_view_url}.rss", params: { n: 3 }
    target = "<?xml version=\"1.0\"?>\n<?xml-stylesheet type=\"text/xsl\" ?>\n<catalog>\n  <cd>\n    <id>3</id>\n    <item>5</item>\n  </cd>\n</catalog>\n"
    # убираем href, т.к. зависит от системы
    actual = @response.body.clone.gsub(/href=.*.xslt"/, '')

    assert_equal actual, target
  end

  test 'should get different responds for different rss requests' do
    get "#{twins_proxy_view_url}.rss", params: { n: 3 }
    response1 = @response.body.clone

    get "#{twins_proxy_view_url}.rss", params: { n: 10 }
    response2 = @response.body.clone

    assert_not_equal response1, response2
  end
end
