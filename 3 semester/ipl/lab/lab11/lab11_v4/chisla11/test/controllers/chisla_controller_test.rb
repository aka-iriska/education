require "test_helper"
# rake test TEST=test/controllers/chisla_controller_test.rb - запуск теста
class ChislaControllerTest < ActionDispatch::IntegrationTest
  # rake db:migrate RAILS_ENV=test - запуск миграции для теста
  # Написать тест на добавление и поиск данных с помощью модели. Проверить выполнение теста.
  def add_record(str = '1 2 3 4 5 6 7 8 9 10', data = '1 2 3 4 5 6 7 8 9 10', table = ' ')
    record = ChislaResult.create :string => str, :result => ActiveSupport::JSON::encode(data), :my_table => table
    record.save
    pp 'Добавлено'
    record
  end

  test "Add data" do
    record = add_record('1 2 3 4 -1 -2 1 2 3 1', '1 2 3 4')
    assert record
  end

  test "Find data" do
    add_record
    record = ChislaResult.find_by_string('1 2 3 4 5 6 7 8 9 10')
    assert record
  end
  # тест на невозможность повторения
  test "Add same result" do
    add_record
    assert_raises(ActiveRecord::RecordNotUnique) do
      add_record
    end
  end

  # проверка маршрутов: rails routes --expanded

  test "should get input" do
    get chisla_input_url
    assert_response :success
  end

  test "should get view" do
    get chisla_view_url
    assert_response :success
  end
  # тест на то, что результаты вычислений различны при различных входных параметрах
  test "different" do
    get chisla_view_url, params: { str: '1 2 3 4 5 6 7 8 9 10' }
    result1 = assigns[:result]

    get chisla_view_url, params: { str: '-1 -2 -3 2 3 4 -2 -3 2 3' }
    result2 = assigns[:result]
    pp result2
    assert_not_same result1, result2
  end
  #тест на то, что запись уже добавлена
  test 'already added' do
    add_record('-1 -2 -3 2 3 4 -2 -3 2 3', '-3 2 3 4', '[["-1 -2 -3 2 3 4 -2 -3 2 3", "-1", " "], [" ", "-2", " "], [" ", "-3 2 3 4", "+"], [" ", "-2", " "], [" ", "-3 2 3", " "]]')
    get chisla_view_url, params: { str: '-1 -2 -3 2 3 4 -2 -3 2 3' }
    result2 = assigns[:result]
    pp result2
    assert_equal(true, result2[2])
  end
end
