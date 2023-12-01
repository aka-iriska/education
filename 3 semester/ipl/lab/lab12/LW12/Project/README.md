## Quick start

### Мега быстрый старт
```shell
rake db:migrate
rake db:migrate RAILS_ENV=test
rake test:controllers
```

- [Гайд](https://railstutorial.ru/chapters/4_0/)
- [Глава 5 - Шаблоны](https://railstutorial.ru/chapters/4_0/filling-in-the-layout#top)
- [Глава 7 - Регистрация](https://railstutorial.ru/chapters/4_0/sign-up/#top)
- [Глава 8 - Вход/Выход](https://railstutorial.ru/chapters/4_0/sign-in-sign-out/#top)

# HTTP Basic Authentication

## Создание модели

Генерируем модель **User**, с полями **email**, **password**

> Note: Важно собдюдать соглашения в наименовании моделей, в единственном числе, 1 словом - это идеально

```shell
rails g scaffold User email:string:uniq
rake db:migrate
rake db:migrate RAILS_ENV=test
```

> Note: Для генерации модели после создания
> приложения: `rails g scaffold User email:string:uniq password_digest:string remember_token:string:index`

Для удаления модели используем:

```shell
rails destroy scaffold User
```

В [Gemfile](twins%2FGemfile) добавляем `gem "bcrypt"`

```shell
bundle install
```

> Note: Для удаления поля используем: `rails generate migration remove_<ПОЛЕ>_from_<ТАБЛИЦА> ПОЛЕ:ТИП`. Пример: `rails generate migration remove_password_from_user password:text`

Добавим возможность использовать `authenticate` и шифрование пароля в
модель [app/models/user.rb](twins%2Fapp%2Fmodels%2Fuser.rb) (Валидации наличия и подтверждения автоматически добавляются
has_secure_password):

```ruby

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
end

```

Для того чтобы получить прохождение этого теста мы вначале генерируем соответствующую миграцию для столбца
password_digest:

```shell
rails generate migration add_password_digest_to_users password_digest:string
rake db:migrate
rake db:migrate RAILS_ENV=test
```

### Тестовые SQL запросы

Вставка:

```sql
INSERT INTO users (email, password_digest, remember_token, created_at, updated_at)
VALUES ('test@email.com', '$2a$12$fPPfThxkvqZwkVqpNbc3u.ehzJv6v3NanqPkzQyPK5TiCx3vr/joO', 'b95a184d03b82f167ef75d6668096eb1e6dd4d2a', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
```

Обновление:

```sql
UPDATE users
SET password_digest='123456789'
WHERE id = 1;
```

Вывод:

```sql
SELECT *
FROM users;
```

Вывод без пароля:

```sql
CREATE VIEW SHOW_USERS AS
SELECT id, email, created_at, updated_at
FROM users;
SELECT *
FROM SHOW_USERS
```

## Генерируем контроллер сессий

Cгенерируем контроллер Sessions и интеграционный тест для механизма аутентификации:

```shell
rails generate controller Sessions --no-test-framework
rails generate integration_test authentication_pages
```

```text
create  app/controllers/sessions_controller.rb
invoke  erb
create    app/views/sessions
invoke  helper
create    app/helpers/sessions_helper.rb
---------------------------------------------------------
invoke  test_unit
create    test/integration/authentication_pages_test.rb
```

## Модификация шаблона

Ставим `bootstrap` и jquery
В `Gemfile`:

```ruby
gem "jquery-rails"
gem "bootstrap"
gem "sassc-rails"
```

В консоли:

```shell
bundle install
```

Создадим папку `app/javascript/src`, а в ней наш `.js` файл [main.js](twins%2Fapp%2Fjavascript%2Fsrc%2Fmain.js)

В `config/initializers/assets.rb`:

```ruby
Rails.application.config.assets.precompile += %w( jquery.min.js jquery_ujs.js bootstrap.min.js popper.js )
```

В `app/assets/stylesheets/application.scss` (обратите внимание, что суффикс файла должен быть `.scss`, а не `.css`, при
необходимости измените суффикс):

```ruby
@import "bootstrap";
```

В `config/importmap.rb`:

```ruby
pin_all_from 'app/javascript/src', under: 'src'
pin "jquery", to: "jquery.min.js", preload: true
pin "jquery_ujs", to: "jquery_ujs.js", preload: true
pin "popper", to: "popper.js", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true
```

В `app/javascript/application.js`:

```ruby
import "jquery"
import "jquery_ujs"
import "popper"
import "bootstrap"
import "src/main"
```

[application.html.erb](twins%2Fapp%2Fviews%2Flayouts%2Fapplication.html.erb) - в базовом варианте выглядит так

```html

<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">ЛР12</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <%= link_to 'Ввод', input_path, class: "nav-link #{ request.path == input_path ? 'active'
                        : '' }" %>
                    </li>
                    <li class="nav-item">
                        <%= link_to 'Вывод', view_path, class: "nav-link #{ request.path == view_path ? 'active' :
                        '' }" %>
                    </li>
                    <li class="nav-item">
                        <%= link_to 'Регистрация', :signup, class: "nav-link #{ request.path == '/signup' ? 'active' :
                        '' }" %>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>
```

## Создание header, footer, блок ошибок и flash сообщения

- [_footer.html.erb](twins%2Fapp%2Fviews%2Flayouts%2F_footer.html.erb)
- [_header.html.erb](twins%2Fapp%2Fviews%2Flayouts%2F_header.html.erb)
- [_shim.html.erb (для IE)](twins%2Fapp%2Fviews%2Flayouts%2F_shim.html.erb)
- [_error_messages.html.erb](twins%2Fapp%2Fviews%2Fshared%2F_error_messages.html.erb)

#### Создадим свой css

[custom.css.scss](twins%2Fapp%2Fassets%2Fstylesheets%2Fcustom.css.scss)

```scss
@import "bootstrap";

html, body {
  height: 100%;
}

html {
  position: relative;
}

footer {
  position: fixed;
  width: 100%;
  bottom: 0;
}

input, textarea, select, .uneditable-input {
  border: 1px solid #bbb;
  width: 100%;
  margin-bottom: 15px;
}

input {
  height: auto !important;
}

#error_explanation {
  color: #f00;

  ul {
    list-style: none;
    margin: 0 0 18px 0;
  }
}

.field_with_errors {
  @extend .control-group !optional;
  @extend .error !optional;
}
```

#### Добавим в [main.js](twins%2Fapp%2Fjavascript%2Fsrc%2Fmain.js) функцию закрытия `flash`

```js
$(document).on('click', '.btn-close', function () {
    $('.alert').fadeOut();
});
```

> Это главный баг фикс по сравнению с 10 лабой, т.к. `.btn-close` - динамический элемент, его состояние нужно
> отслеживать с помощью метода `on`, стандартный `ajax:success` и тп работать не будет

## Создание формы Регистрации

[Гайд](https://railstutorial.ru/chapters/4_0/sign-up/#top)

Отредактируем [routes.rb](twins%2Fconfig%2Froutes.rb), добавим туда страницу регистрации, входа и выхода:

```ruby
match '/signup', to: 'users#new', via: 'get'
match '/signin', to: 'sessions#new', via: 'get'
match '/signout', to: 'sessions#destroy', via: 'delete'
```

Отредактируем [new.html.erb](twins%2Fapp%2Fviews%2Fusers%2Fnew.html.erb), чтобы форма регистрации выглядела +- норм.
Чтобы проверить пути используем:

```shell
rails routes --expanded
```

```html
<% provide(:title, 'Sign up') %>
<h1>Регистрация</h1>

<div class="row">
    <div class="span6 offset3">
        <%= form_for(@user) do |f| %>
        <%= render 'shared/error_messages' %>

        <%= f.label :email %>
        <%= f.text_field :email, class: "form-control", required: true %>

        <%= f.label 'Пароль' %>
        <%= f.password_field :password, class: "form-control", required: true %>

        <%= f.label 'Подтверждение пароля', "Confirmation" %>
        <%= f.password_field :password_confirmation, class: "form-control", required: true %>

        <%= f.submit "Зарегестрироваться", class: "btn btn-large btn-primary mt-4" %>
        <% end %>
    </div>
</div>
```

Добавим [custom.css.scss](twins%2Fapp%2Fassets%2Fstylesheets%2Fcustom.css.scss) со следующим кодом:

```css
input, textarea, select, .uneditable-input {
    border: 1px solid #bbb;
    width: 100%;
    margin-bottom: 15px;
}

input {
    height: auto !important;
}
```

Создадим файл для отображения ошибок [_error_messages.html.erb](twins%2Fapp%2Fviews%2Fshared%2F_error_messages.html.erb)
и отрендерим его в [new.html.erb](twins%2Fapp%2Fviews%2Fusers%2Fnew.html.erb)

Стилизуем ошибки [custom.css.scss](twins%2Fapp%2Fassets%2Fstylesheets%2Fcustom.css.scss):

```scss
#error_explanation {
  color: #f00;

  ul {
    list-style: none;
    margin: 0 0 18px 0;
  }
}

.field_with_errors {
  @extend .control-group;
}
```

Отредактируем [users_controller.rb](twins%2Fapp%2Fcontrollers%2Fusers_controller.rb), чтобы проверять пароли на
совпадение.

```ruby

def create
  msg_text = ''
  msg_status = :success

  email = params[:user][:email]
  password = params[:user][:password]
  password_confirmation = params[:user][:password_confirmation]
  puts password

  @user = User.new(user_params)

  respond_to do |format|

    if @user
      if User.find_by_email(email)
        msg_text = 'Пользователь уже зарегестрирован!'
        msg_status = :danger
      elsif password != password_confirmation
        msg_text = 'Пароль для подтверждения введен неверно'
        msg_status = :danger
      elsif !email.match?('[a-z0-9]+[_a-z0-9\.-]*[a-z0-9]+@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})')
        msg_text = 'Введите почту корректно'
        msg_status = :danger
      end

      if msg_status == :success and @user.save
        msg_text = 'Спасибо за регистрацию'
        flash[msg_status] = msg_text

        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        flash.now[msg_status] = msg_text
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
```

## Создание формы Входа

Оформим [new.html.erb](twins%2Fapp%2Fviews%2Fsessions%2Fnew.html.erb), очень схоже с Sign up

```html
<% provide(:title, "Sign in") %>
<h1>Sign in</h1>

<div class="row">
    <div class="span6 offset3">
        <%= form_for(:session, url: sessions_path) do |f| %>

        <%= f.label :email %>
        <%= f.text_field :email, class: "form-control", required: true %>

        <%= f.label 'Пароль' %>
        <%= f.password_field :password, class: "form-control", required: true %>

        <%= f.submit "Войти", class: "btn btn-large btn-primary mt-4" %>
        <% end %>

        <p>Еще не зарегистрированы? <%= link_to "Зарегестрироватья сейчас!", signup_path %></p>
    </div>
</div>
```

Добавим токен для хранения сессии путем создания миграции:

```shell
rails generate migration add_remember_token_to_users remember_token:string:index
rake db:migrate
rake db:migrate RAILS_ENV=test
```

Отредактируем [app/controllers/application_controller.rb](twins%2Fapp%2Fcontrollers%2Fapplication_controller.rb), чтобы
сохранять сессию навсегда

```ruby

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
end
```

Отредактируем [sessions_controller.rb](twins%2Fapp%2Fcontrollers%2Fsessions_controller.rb)

```ruby

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_create :create_remember_token

                ...

                  def User.new_remember_token
                    SecureRandom.urlsafe_base64
                  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
```

[app/helpers/sessions_helper.rb](twins%2Fapp%2Fhelpers%2Fsessions_helper.rb) чтобы хранить сессию в куках:

```ruby

module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  # Пользователь является вошедшим если в сессии существует текущий пользователь, т.e., если current_user не является nil
  def signed_in?
    !current_user.nil?
  end

  # Поиск текущего пользователя с помощью remember_token.
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
end
```

Обновляем [_header.html.erb](twins%2Fapp%2Fviews%2Flayouts%2F_header.html.erb), добавив увловие:

```html
<% if signed_in? %>
<% else %>
<% end %>
```

Вход пользователя сразу после
регистрации [app/controllers/users_controller.rb](twins%2Fapp%2Fcontrollers%2Fusers_controller.rb)

```ruby

if msg_status == :success and @user.save
  sign_in @user
  msg_text = 'Спасибо за регистрацию'
  flash[msg_status] = msg_text
```

Редактируем [controllers/twins_controller.rb](twins%2Fapp%2Fcontrollers%2Ftwins_controller.rb), чтобы при входе на страницу ввода/вывода, перебрасывало на вход, если он еще не осуществлен:
```ruby

def input
  unless signed_in?
    redirect_to signin_path
  end
end

def view
  unless signed_in?
    redirect_to signin_path
  end

  # ............
end
```

## Выход пользователя

[sessions_controller.rb](twins%2Fapp%2Fcontrollers%2Fsessions_controller.rb)

```ruby

class SessionsController < ApplicationController

  def destroy
    sign_out
    redirect_to root_url
  end
end
```

Метод sign_out в модуле Sessions хелпер [app/helpers/sessions_helper.rb](twins%2Fapp%2Fhelpers%2Fapplication_helper.rb)

```ruby

def sign_out
  current_user.update_attribute(:remember_token,
                                User.encrypt(User.new_remember_token))
  cookies.delete(:remember_token)
  self.current_user = nil
end
```

## Тесты
[Гайд sign_up](https://www.softcover.io/read/28fdb94f/ruby_on_rails_tutorial_3rd_edition/sign_up)

[Гайд Login/Logout](https://www.softcover.io/read/28fdb94f/ruby_on_rails_tutorial_3rd_edition/log_in_log_out)

Удалите если есть - [test/fixtures/users.yml](twins%2Ftest%2Ffixtures%2Fusers.yml)

Базовый тест вычислений (со времен 8 лабы):
[twins_controller_test.rb](twins%2Ftest%2Fcontrollers%2Ftwins_controller_test.rb)

```shell
rake test:controllers
```

#### Тест 1: Подготовить интеграционный тест, позволяющий проверить регистрацию нового пользователя, вход под его именем и выполнение вычислений.

[test/integration/authentication_pages_test.rb](twins%2Ftest%2Fintegration%2Fauthentication_pages_test.rb)
```ruby
require "test_helper"
# https://www.softcover.io/read/28fdb94f/ruby_on_rails_tutorial_3rd_edition/sign_up

class AuthenticationPagesTest < ActionDispatch::IntegrationTest
  def add_record(email, password)
    record = User.new(:email => email, :password => password)
    record.save
    record
  end

  ################################## Sign up ######################################
  # Проверяем доступность страницы регистрации
  test "test registration page access" do
    get signup_url
    assert_response :success
  end

  # Проверяем, что нельзя зарегестрировать того же пользователя
  test 'attempt to register with existing user details' do
    # Создаем пользователя
    add_record('test@test.com', '123456')

    get signup_url
    assert_response :success

    post users_url, params: { "authenticity_token" => "token", "user" => { "email" => "test@test.com", "password" => "123456", "password_confirmation" => "123456" } }

    assert_response 422
  end

  # Проверяем, что пользователя можно зарегестрировать
  test 'successfully user registration' do
    get signup_url
    assert_response :success

    # Смотрим, что такой пользователь только 1
    assert_difference 'User.count', 1 do
      post users_url, params: { "authenticity_token" => "token", "user" => { "email" => "test@test.com", "password" => "123456", "password_confirmation" => "123456" } }
      follow_redirect!
    end

    assert_template 'input'
    assert_response 200
  end

  ################################## Sign in ######################################
  # Проверяем доступность страницы входа
  test "test login page access" do
    get signin_url
    assert_response :success
  end

  test 'successfully user login' do
    add_record('test@test.com', '123456')

    assert_difference 'User.count', 0 do
      post sessions_url, params: { "authenticity_token" => "token", "session" => { "email" => "test@test.com", "password" => "123456" } }
      follow_redirect!
    end

    assert_template 'input'
    assert_response 200
  end

  test 'login of a non-existent user' do
    post sessions_url, params: { "authenticity_token" => "token", "session" => { "email" => "test@test.com", "password" => "123456" } }

    assert_template 'sessions/new'
    assert_response 422
  end

  test 'login without password' do
    post sessions_url, params: { "authenticity_token" => "token", "session" => { "email" => "test@test.com", "password" => "" } }

    assert_template 'sessions/new'
    assert_response 422
  end

  ################################## Sign out ######################################
  test "test logout success" do
    # Добавляем тестового юзера в БД
    add_record('test@test.com', '123456')

    assert_difference 'User.count', 0 do
      # login
      post sessions_url, params: { "authenticity_token" => "token", "session" => { "email" => "test@test.com", "password" => "123456" } }
      follow_redirect!
    end

    assert_difference 'User.count', 0 do
      # Logout
      delete signout_url
      follow_redirect! # перенаправлены в input, там проверочка, что не залогинились и иедм в login
      follow_redirect! # из input в login
    end

    assert_template 'sessions/new'
    assert_response 200
  end
end
```

## Тест 2. Подготовить интеграционный тест для проверки невозможности выполнения вычислений без ввода логина/пароля

Модифицируем предыдущий тест
```ruby
  test "Calculations are impossible without sign in" do
    # view
    get view_url, params: { n: 10 }

    # Если не вошли, значит редиректимся в signin
    assert_response 302

    # input
    get input_url
    assert_response 302
  end
```

```shell
rake test:integration
```

### Измененные файлы

1) **assets**
    - [stylesheets/application.scss](twins%2Fapp%2Fassets%2Fstylesheets%2Fapplication.scss)
    - [stylesheets/custom.css.scss](twins%2Fapp%2Fassets%2Fstylesheets%2Fcustom.css.scss)
2) **controllers**
    - [controllers/application_controller.rb](twins%2Fapp%2Fcontrollers%2Fapplication_controller.rb)
    - [controllers/sessions_controller.rb](twins%2Fapp%2Fcontrollers%2Fsessions_controller.rb)
    - [controllers/twins_controller.rb](twins%2Fapp%2Fcontrollers%2Ftwins_controller.rb)
    - [controllers/users_controller.rb](twins%2Fapp%2Fcontrollers%2Fusers_controller.rb)
3) **helpers**
    - [helpers/sessions_helper.rb](twins%2Fapp%2Fhelpers%2Fsessions_helper.rb)
4) **javascript**
    - [javascript/controllers/application.js](twins%2Fapp%2Fjavascript%2Fapplication.js)
    - [javascript/src/main.js](twins%2Fapp%2Fjavascript%2Fsrc%2Fmain.js)
5) **model**
    - [models/user.rb](twins%2Fapp%2Fmodels%2Fuser.rb)
6) **layouts**
    - [layouts/_footer.html.erb](twins%2Fapp%2Fviews%2Flayouts%2F_footer.html.erb)
    - [layouts/_header.html.erb](twins%2Fapp%2Fviews%2Flayouts%2F_header.html.erb)
    - [layouts/_shim.html.erb](twins%2Fapp%2Fviews%2Flayouts%2F_shim.html.erb)
    - [layouts/application.html.erb](twins%2Fapp%2Fviews%2Flayouts%2Fapplication.html.erb)
7) **sessions**
    - [sessions/destroy.html.erb](twins%2Fapp%2Fviews%2Fsessions%2Fdestroy.html.erb)
    - [sessions/new.html.erb](twins%2Fapp%2Fviews%2Fsessions%2Fnew.html.erb)
8) **shared**
    - [_error_messages.html.erb](twins%2Fapp%2Fviews%2Fshared%2F_error_messages.html.erb)
9) **twins**
    - [twins/input.html.erb](twins%2Fapp%2Fviews%2Ftwins%2Finput.html.erb)
    - [twins/view.html.erb](twins%2Fapp%2Fviews%2Ftwins%2Fview.html.erb)
10) **users**
    - [users/new.html.erb](twins%2Fapp%2Fviews%2Fusers%2Fnew.html.erb)
11) **config**
    - [environments/development.rb](twins%2Fconfig%2Fenvironments%2Fdevelopment.rb)
    - [initializers/assets.rb](twins%2Fconfig%2Finitializers%2Fassets.rb)
    - [routes.rb](twins%2Fconfig%2Froutes.rb)
    - [importmap.rb](twins%2Fconfig%2Fimportmap.rb)
12) [Gemfile](twins%2FGemfile)

### Пути:
