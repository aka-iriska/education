require "test_helper"

class ChislaProxyControllerTest < ActionDispatch::IntegrationTest
  BASE_API_URL = 'http://127.0.0.1:3000/chisla_api/view'
  test "should get input" do
    get chisla_proxy_input_url
    assert_response :success
  end

  test "should get view" do
    get chisla_proxy_view_url
    assert_response :success
  end
  # функциональный тест, проверяющий что при различных входных данных результат генерируемой страницы различен
  test 'check differ' do
    get chisla_proxy_view_url, params: { str: '1 2 3 4 5 6 7 8 9 10' }
    result1 = assigns[:output]

    get chisla_proxy_view_url, params: { str: '-1 -2 -3 2 3 4 -2 -3 2 3' }
    result2 = assigns[:output]

    assert_not_same result1, result2
  end
  # браузер получает XML первого приложения в неизменном виде.
  test 'XML is unchanged' do
    query_str = "#{BASE_API_URL}.xml"
    query_str << '?str=1+2+3+4+5+6+7+8+9+10'
    uri = URI(query_str)
    res = Net::HTTP.get_response(uri)

    target = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<output>\n  &lt;catalog&gt;&lt;cd&gt;&lt;former&gt;1 2 3 4 5 6 7 8 9 10&lt;/former&gt;&lt;every&gt;1 2 3 4 5 6 7 8 9 10&lt;/every&gt;&lt;plus&gt;+&lt;/plus&gt;&lt;/cd&gt;&lt;/catalog&gt;\n</output>"

    assert_equal target, res.body
  end
  #функциональные тесты второго приложения (proxy)
  test 'check html proxy' do
    get chisla_proxy_view_url, params: { str: '1 2 3 4 5 6 7 8 9 10' }
    result = assigns[:output]
    target = "<table border=\"1\">\n<tr bgcolor=\"#9933ff\">\n<th>Former</th>\n<th>All</th>\n<th>The longest</th>\n</tr>\n<tr>\n<td>1 2 3 4 5 6 7 8 9 10</td>\n<td>1 2 3 4 5 6 7 8 9 10</td>\n<td>+</td>\n</tr>\n</table>\n"
    assert_equal result, target
  end

  test 'check xml proxy' do
    get "#{chisla_proxy_view_url}.xml", params: { str: '1 2 3 4 5 6 7 8 9 10' }
    target = "<?xml version=\"1.0\"?>\n<?xml-stylesheet type=\"text/xsl\" ?>\n<catalog>\n  <cd>\n    <former>1 2 3 4 5 6 7 8 9 10</former>\n    <every>1 2 3 4 5 6 7 8 9 10</every>\n    <plus>+</plus>\n  </cd>\n</catalog>\n"
    result= assigns[:output].gsub(/href=.*.xslt"/, '') # чтобы без пк и папок
    assert_equal result, target
  end
  #RSS тест
  test 'check rss' do
    get "#{chisla_proxy_view_url}.rss", params: { str: '1 2 3 4 5 6 7 8 9 10'  }
    target = "<?xml version=\"1.0\"?>\n<?xml-stylesheet type=\"text/xsl\" ?>\n<catalog>\n  <cd>\n    <former>1 2 3 4 5 6 7 8 9 10</former>\n    <every>1 2 3 4 5 6 7 8 9 10</every>\n    <plus>+</plus>\n  </cd>\n</catalog>\n"
    assert_equal @response.body.clone.gsub(/href=.*.xslt"/, ''), target
  end

  test 'different for rss requests' do
    get "#{chisla_proxy_view_url}.rss", params: { str: '1 2 3 4 5 6 7 8 9 10'  }
    response1 = @response.body.clone

    get "#{chisla_proxy_view_url}.rss", params: { str: '2 3 4 5 6 7 8 9 10 11'  }
    response2 = @response.body.clone

    assert_not_equal response1, response2
  end
end
