# Avoidant

## Запуск репозитория

```shell
rake app:update:bin
```

```shell
rails new avoidant
```

## ТЗ

**Avoidant** - Избегатель общения

**Идея**: Портал «Ищу тебя», где люди могут создать пост о человеке, увиденном на улице или в любом общественном месте,
который улыбнулся им или пересёкся взглядом.

Получается своего рода доска объявлений с поиском пропавших. К примеру, если друг этого человека сидит на сайте, то он
может найти его и передать, что его кто-то ищет.

**Особенность**: Если нет фотографии, она генерируется по описанию.

#### **Страницы**:

Регистрация/вход/выход, как в 12 лабе. Без входа, нельзя создать запрос на поиск человека.

Если человек найден, открывается страница people, если нет, на ней же выводится ошибка. Чтобы откликнуться, нужно нажать
на кнопку и будет вариант, ВК, почта, телефон и т.п.

- index - главная (инфа о проекте и т. п.) + строка поиска с фильтром как на странице find, при нажатии кнопки найти,
  открывает страницу найденных людей;
- find - страница с вводом данных о человеке (возраст, пол, цвет глаз, волос и тп), при нажатии кнопки добавить,
  добавляем человека в БД, но только, если пользователь зарегестрирован;
- people - страница найденных людей - то что нашлось по описанию, достаем из БД;
- people#id - конкретный пост о человеке + отклики на него;
- home (домашняя страница аккаунта с инфой о нем и опубликованными постами).
  БД: Таблица зарегистрированных пользователей **User**, от нее, по внешнему ключу ссылка на таблицу людей, которых ищут
  **PeopleFind**.

Интернализация: Зависит от языка системы (en/ru, ru - по-умолчанию)

## Схема БД

- **User**
    - **id (PK)**: *integer* - id пользователя (генерируется автоматически)
    - **name**: string - ФИО пользователя
    - **email**: string - почта пользователя
    - **password_digest**: string - пароль пользователя в зашифрованном виде
    - **remember_token**: string - токен сесии
- **PeopleFind**:
    - **user_id (FK)**: integer - кто создал запрос на поиск
    - **searcher_email**: string - email человека, создавшего запрос
    - **searcher_name**: string - ФИО человека, создавшего запрос
    - **address**: string - адрес, место, где встретил человка
    - **gender**: string - пол (м/ж)
    - **age**: integer - возраст
    - **body_type**: string - телосложение (эктоморф, мезоморф, эндоморф)
    - **height**: integer - рост (в см)
    - **race**: string - расса (европиоид, негроид, монголоид, другое)
    - **facial_hair**: string - растительность на лице (есть/нет)
    - **voce**: string - голос (сопрано, тенор, альт, баритон, контральто, бас)
    - **hair_color**: string - цвет волос (rgb)
    - **forehead**: string - лоб (прямой скошенный, покатый, прямой, округлый, выпуклый, волнистый скошенный)
    - **ears**: string - уши (круглые, угловатые, заостренные, торчащие, свободная мочка, прилегающая мочка, широкая
      мочка)
    - **wrinkles**: string - морщины (есть/нет)

## Создание контроллеров

Генерация страниц сайта:

```shell
rails generate controller Avoidant index people home 
rails generate controller Sessions --no-test-framework
```

Создание БД

> Note Find - helper модуль в rails, поэтому его нельзя использовать. Используем `PeopleFind` либо пространство имен. В нашем случае были убраны гемы `selenium` и `capybara`

```shell
rails g scaffold User name:string email:string:uniq password_digest:string remember_token:string:index admin:boolean

rails g scaffold PeopleFind address:string user:references gender:string age:integer body_type:string height:integer race:string facial_hair:string voice:string hair_color:string forehead:string ears:string wrinkles:string

rake db:migrate
rake db:migrate RAILS_ENV=test
```

Удаление таблицы
```shell
rails destroy scaffold User
```

Сброс таблиц БД

```shell
rails db:seed:replant
```

## Миграции

### Изменение типа данных:

```shell
rails generate migration Change<Column>Type
```

```ruby

class ChangeColumnType < ActiveRecord::Migration[7.1]
  def change
    change_column :table_name, :column_name, :new_type
  end
end
```

### Изменение имени таблицы
```shell
rails generate migration RenameFindNameToPeopleFind
```

```ruby
rename_table :old_table_name, :new_table_name
```

### Добавление FK
```shell
rails generate migration add_people_find_to_finds people_find:references
```

### Добавление новой строки

```shell
rails generate migration add_<column>_to_<table>s column:string

rails generate migration add_searcher_email_and_searcher_name_to_finds searcher_email:string searcher_name:string
```

```shell
rails db:migrate
rake db:migrate RAILS_ENV=test
```

## Создадим js как в 12 лабе
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

Создадим папку `app/javascript/src`, а в ней наш `.js` файл [main.js](app%2Fjavascript%2Fsrc%2Fmain.js)

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
pin 'jquery', to: 'jquery.min.js', preload: true
pin 'jquery_ujs', to: 'jquery_ujs.js', preload: true
pin 'popper', to: 'popper.js', preload: true
pin 'bootstrap', to: 'bootstrap.min.js', preload: true
```

В `app/javascript/application.js`:

```ruby
import "jquery"
import "jquery_ujs"
import "popper"
import "bootstrap"
import "src/main"
```

## Добавление FA

[Gemfile](Gemfile)

```ruby
gem 'font-awesome-sass'
```

[application.scss](app%2Fassets%2Fstylesheets%2Fapplication.scss)

```scss
@import "font-awesome";
```

## Динамическое обновление контента

Калоруби для каждого запроса (будь то ajax или простой запрос от пользователя) создает новый объект класса контроллера,
следовательно, переменные объекта класса на сохраняются. Поэтому, чтобы созранять какие-то значения, их надо записывать
в БД, либо хранить в переменной класса через `@@`, при этом ее нельзя просто использовать, нужно присваивать ее
переменной объекта класса. Выглялдит это следующим образом `@users = @@users`, иначе будет ошибка, т.к. контроллер не
работает напрямую с элементами объекта класса т.к. это нарушает принцип MVC.

Также, не нужно забывать, что Rails сам по себе динамически обнолвяет элементы и привязав по id событие к одному
элементу, при каких то действиях на стрице, это по факту будет другой элемент (с тем же id). Решение этой проблемы
пришло мне во время прослушивания Оксимирона в 3 ночи и будет описано ниже.

На примере демонстрации элементов БД по 10 штук за раз (типа пагинация).

Добавим в [routes.rb](config%2Froutes.rb) путь для функции, выполняющую добавление новых 10 элементов на страницу

```ruby
get 'avoidant/load_more'
```

Создадим стандартный html шаблон в папке avoidant (имя контроллера) и js шаблон для работы с js.

- [load_more.html.erb](app%2Fviews%2Favoidant%2Fload_more.html.erb) - `html` шаблон оставляем пустым
- [load_more.js.erb](app%2Fviews%2Favoidant%2Fload_more.js.erb) - срабатывает при создании запроса в функцию контролерра
  с помощью AJAX

В класс контроллера `AvoidantController` добавим переменную класса `@@current_users = nil`

```ruby

def load_more
  pp 'load_more elements', @@current_users.length
  session[:element_per_page] = session[:element_per_page] + 10
  @all_users = @@current_users.limit(session[:element_per_page])

  respond_to do |format|
    format.js
  end
end
```

Все пользователи загружаются при первом запуске страницы, в данном случае в функции people

```ruby

def people
  pp 'people: ', params

  @@current_users = Find.all
  session[:element_per_page] = 10
  @all_users = @@current_users.limit(10)

  respond_to do |format|
    format.html
    format.json do
      pp "RENDER JS"
      render json:
               { type: @filter_request.class.to_s, value: @filter_request }
    end
  end
end
```

Создадим шаблон в папке layouts для красивой отрисовки нашей БД (обязательно название с нижним подчеркиванием, чтобы не
рендерился как layout) [_users_list.html.erb](app%2Fviews%2Flayouts%2F_users_list.html.erb) - пример сильно упрощен

```html
<% @all_users.each_with_index do |user, ind| %>
<span class="badge bg-primary rounded-pill"><%= ind + 1 %></span>
<span class="first-big"><%= user.address %></span>
<span class="first-big"><%= user.gender %></span>
```

В html шаблоне, который рендерится при заходе на стринцу (в моем случае это people) добавляем кнопку Загрузить еще и
рендер самого шаблона выше [people.html.erb](app%2Fviews%2Favoidant%2Fpeople.html.erb):

```html

<div id="users-list">
    <%= render 'layouts/users_list' %>
</div>

<div class="col">
    <div id="load_more_users" class="text-end p-3">
        <%= button_to 'Загрузить еще', { action: "load_more", new_req: true }, method: :get, remote: true, class: "btn
        btn-primary btn-large" %>
    </div>
</div>
```

Данный шаблон создаст форму, которая отправляет get запрос функции `load_more`, класса контроллера `Avoidant`.

В шаблоне для `js` ответа перерендерим наш шаблон в соответствии с измененной
переменной `@all_users` - [update_people.js.erb](app%2Fviews%2Favoidant%2Fupdate_people.js.erb)

```js
console.log('Dynamic add more');
$('#users-list').html("<%= j render 'layouts/users_list' %>");
```

И наконец редактируем `js` файл, который мы создали ранее в папке src слушаем успешную отправку формы.
В данном случае нам не нужен AJAX, т.к. не надо сохранять какие-то параметры в запросе и выполнять работу в
отдельном `js` + формат запроса не json (`data-type!="json"`) => автоматически при remote=true для формы будет
отрисовываться js шаблон. Для примера ниже, форма отправила запрос по пути people, он был перехвачен и направлен в
update_people вместе с параметрами (сохранять значения можно в сесии `session[:val] = 10`):

[people.html.erb](app%2Fviews%2Favoidant%2Fpeople.html.erb)

```html

<form action="/avoidant/people?filtered=true" method="get" data-remote="true" id="people_form" accept-charset="UTF-8"
      data-type="json">
```

[avoidant_controller.rb](app%2Fcontrollers%2Favoidant_controller.rb)

```ruby

def people
  respond_to do |format|
    format.html
    format.json do
      pp "RENDER JSON"
      render json:
               { type: @filter_request.class.to_s, value: @filter_request }
    end
  end
end
```

[main.js](app%2Fjavascript%2Fsrc%2Fmain.js)

```js
function send_request(value) {
    console.log('value:', value);
    $.ajax({
        url: 'http://localhost:3000/update_people',
        type: 'GET',
        dataType: 'script',
        data: {filter: value},
    });
}


$(document).ajaxSuccess(function (event, request, options, data) {
    let form_url = options.url
    console.log('people_form success', data, 'form url', form_url);

    if (form_url.includes('avoidant/people')) {
        send_request(data.value);
    }
});
```

`ajaxSuccess` - глобальное событие и решает проблему с динамическими элементами rails

## Регистрация

В Gemfile:

```ruby
gem "bcrypt", "~> 3.1.7"
```

Добавим возможность использовать `authenticate` и шифрование пароля в модель `app/models/user.rb` (Валидации наличия и
подтверждения автоматически добавляются `has_secure_password`). А также добавим токен сессии:

```ruby

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

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

#### Добавим лэйауты [_header.html.erb](app%2Fviews%2Flayouts%2F_header.html.erb) и [_footer.html.erb](app%2Fviews%2Flayouts%2F_footer.html.erb):

Header
```html
<header>
  <nav class="navbar navbar-expand-lg border-bottom bg-body-tertiary">
    <div class="container-fluid">

      <%= link_to index_path, class: "navbar-brand navbar-left" do %>
        <%= image_tag("logo.png", height: '32', width: '32', alt: "logo", class: "d-inline-block align-text-top") %>
        Avoidant
      <% end %>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <%= link_to 'Главная', index_path, class: "nav-link  #{ request.path == index_path ? 'active' : ''  }" %>
          </li>

        </ul>
      </div>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
          <% if signed_in? %>
            <li class="nav-item">
              <%= link_to 'Аккаунт', home_path, class: "nav-link  #{ request.path == home_path ? 'active' : ''  }" %>
            </li>

          <% else %>
            <li class="nav-item">
              <%= link_to 'Вход', signin_path, class: "nav-link  #{ request.path == signin_path ? 'active' : ''  }" %>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
  </nav>
</header>

```

Footer
```html
<footer class="footer mt-auto py-3 text-center text-lg-start primary-bg">
  <div class="container text-center text-dark">
    © 2023 Copyright
  </div>
</footer>

```

> Note: Если вначале имени лэйаута `_` это тоже самое что `layout: false`

Прописываем [routes.rb](config%2Froutes.rb)

```ruby
resources :sessions

# Базовые пути
match '/index', to: 'insu_calc#index', via: 'get'
match '/home', to: 'insu_calc#home', via: 'get'

# Пути регистрации
match '/signup', to: 'users#new', via: 'get'
match '/signin', to: 'sessions#new', via: 'get'
match '/signout', to: 'sessions#destroy', via: 'delete'

root "insu_calc#index"
```

Обновим в связи с изменениями выше [application.html.erb](app%2Fviews%2Flayouts%2Fapplication.html.erb) и заодно добавим
лого:

```html

<html lang="ru" class="h-100">

<head>
    <link rel="icon" type="image/png" href="/assets/logo.png">
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
</head>

<body class="d-flex flex-column h-100">
<%= render 'layouts/header' %>
<div class="container mb-3">
    <div class="mt-1">
        <% flash.each do |key, value| %>
        <div class="alert alert-<%= key %> alert-dismissible fade show" role="alert"><%= value %>
            <button id="flash-close" type="button" class="btn-close" data-dismiss="alert">
            </button>
        </div>
        <% end %>
    </div>
    <%= yield %>
</div>

<%= render 'layouts/footer' %>

</body>
```

И сразу добавим [main.js](app%2Fjavascript%2Fsrc%2Fmain.js) для закрытия уведомлений:

```js
$(document).on('click', '.btn-close', function () {
    $('.alert').fadeOut();
});

```

### Форма регистрации [new.html.erb](app%2Fviews%2Fusers%2Fnew.html.erb)

```html
<% provide(:title, 'Sign up') %>
<h1><%= 'Регистрация' %></h1>

<div class="row">
    <div>
        <%= form_for(@user) do |f| %>

        <div class="mb-3">
            <%= f.label :name, 'ФИО', class: "form-label" %>
            <%= f.text_field :name, class: "form-control", required: true %>
        </div>

        <div class="mb-3">
            <%= f.label :email, class: "form-label" %>
            <%= f.email_field :email, class: "form-control", required: true %>
        </div>

        <div class="mb-3">
            <%= f.label password, 'Пароль', class: "form-label" %>
          <%= f.password_field :password, minlength: 6, class: "form-control", required: true %>
        </div>

        <div class="mb-3">
            <%= f.label :password_confirmation, 'Подтвердите пароль', class: "form-label" %>
            <%= f.password_field :password_confirmation, minlength: 6, class: "form-control", suggested: "new-password",
            required: true %>
        </div>

        <%= f.submit 'Зарегестрироваться', class: "btn btn-large btn-primary mt-4" %>
        <% end %>
    </div>

  <div class="mt-3">
    <p class="text-xl-start text-wrap">"Уже зарегистрированы" <%= link_to 'Войти', signin_path %></p>
  </div>
</div>
```

Тут же редактируем контроллер [controllers/users_controller.rb](app%2Fcontrollers%2Fusers_controller.rb), чтобы выдавать ошибки:

```ruby

def create
  pp 'Create user'

  msg_text = ''
  msg_status = :success

  email = params[:user][:email]
  password = params[:user][:password]
  password_confirmation = params[:user][:password_confirmation]

  print 'password: ', password, ' ', password_confirmation, "\n"

  params[:user][:admin] = false
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
        sign_in @user
        msg_text = 'Спасибо за регистрацию'
        flash[msg_status] = msg_text

        format.html { redirect_to home_path }
        format.json { render :show, status: :created, location: home_path }
      else
        if msg_text.empty?
          msg_text = "Неверные данные - #{@user.errors.objects.first.full_message}"
          msg_status = :danger
        end

        pp 'msg_status', msg_status
        pp 'msg', msg_text

        flash.now[msg_status] = msg_text
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end

def user_params
  params.require(:user).permit(:name, :email, :manager, :admin, :password, :remember_token)
end
```

## Форма Входа [sessions/new.html.erb](app%2Fviews%2Fsessions%2Fnew.html.erb)

```html
<% provide(:title, "Sign in") %>
<h1><%= 'Вход' %></h1>

<div class="row">
    <div>
        <%= form_for(:session, url: sessions_path) do |f| %>
        <div class="mb-3">
            <%= f.label :email, class: "form-label" %>
            <%= f.text_field :email, class: "form-control", required: true %>
        </div>

        <div class="mb-1">
            <%= f.label :password, 'Пароль', class: "form-label" %>
            <%= f.password_field :password, minlength: 4, class: "form-control", required: true %>
        </div>

        <%= f.submit 'Войти', class: "btn btn-large btn-primary mt-4" %>
        <% end %>

        <div class="mt-3">
            <p class="text-xl-start text-wrap">Еще не зарегистрированы? <%= link_to 'Зарегестрироватья сейчас!',
                signup_path %></p>
        </div>
    </div>
</div>
```

Отредактируем [controllers/application_controller.rb](app%2Fcontrollers%2Fapplication_controller.rb), чтобы
сохранять сессию навсегда:

```ruby
protect_from_forgery with: :exception
include SessionsHelper
```

Отредактируем [helpers/sessions_helper.rb](app%2Fhelpers%2Fsessions_helper.rb):

```ruby

module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
end
```

Добавим вход в [controllers/sessions_controller.rb](app%2Fcontrollers%2Fsessions_controller.rb):

```ruby

def new; end

def create
  msg_text = ''
  msg_status = :success

  email = params[:session][:email]
  password = params[:session][:password]

  puts password

  respond_to do |format|
    user = User.find_by(email: email.downcase)

    if !user
      msg_text = 'Пользователя не существует'
      msg_status = :danger
    elsif !user.authenticate(password)
      msg_text = 'Неверный пароль'
      msg_status = :danger
    end

    if msg_status == :success
      sign_in user
      msg_text = 'Вы успешно вошли'
      flash[msg_status] = msg_text
      format.html { redirect_to home_path }
      format.json { render :show, status: :created, location: home_path }
    else
      if msg_text.empty?
        msg_text = "Неверные данные - #{@user.errors.objects.first.full_message}"
        msg_status = :danger
      end

      flash.now[msg_status] = msg_text
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end
```

### Выход пользователя

Добавляем такой метод в [controllers/sessions_controller.rb](app%2Fcontrollers%2Fsessions_controller.rb):

```ruby

class SessionsController < ApplicationController
  def destroy
    sign_out
    redirect_to root_url
  end
end

```

### Доп. перед запуском регистрации

Добавим:

- [logo.png](app%2Fassets%2Fimages%2Flogo.png)
- [custom.scss](app%2Fassets%2Fstylesheets%2Fcustom.scss)
  ```scss
  @import "bootstrap";
  
  .primary-bg {
  background-color: #FFDD2D;
  }
  ```

## Интернализация (переводы)

В папку [locales](config%2Flocales) добавляем файл русским языком

[en.yml](config%2Flocales%2Fen.yml)

```yaml
en:
  main: 'Main'
  people: 'People'
  create_post: 'Create post'
...
```

[ru.yml](config%2Flocales%2Fru.yml)

```yaml
ru:
  main: 'Главная'
  people: 'Люди'
  create_post: 'Создать пост'
...
```

[application.rb](config%2Fapplication.rb)

```ruby
I18n.available_locales = [:ru, :en]
I18n.default_locale = :ru
```

[application_controller.rb](app%2Fcontrollers%2Fapplication_controller.rb)

```ruby
before_action :set_locale

private

def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
end

def default_url_options
  { locale: I18n.locale }
end
```

[routes.rb](config%2Froutes.rb) - оборачиаем все в `scope`

```ruby
scope "(:locale)", locale: /en|ru/ do
  ...
end
```

[_header.html.erb](app%2Fviews%2Flayouts%2F_header.html.erb) - и добавим сам список для выбора языка

```html

<ul class="navbar-nav">
    <% I18n.available_locales.each do |locale| %>
    <% if I18n.locale != locale %>
    <li class="nav-item">
        <%= link_to t(".lang.#{locale}"), url_for(locale: locale) %>
    </li>
    <% end %>
    <% end %>
</ul>
```

## Темная тема

```html

<button id="theme_btn" class="btn btn-primary btn-rounded navbar-btn ms-2">
    <i class="fa-brands fa-affiliatetheme"></i>
</button>
```

[main.js](app%2Fjavascript%2Fsrc%2Fmain.js)

```js
window.onload = (event) => {
    const theme = localStorage.getItem('theme');

    if (!theme) {
        localStorage.setItem('theme', 'dark');
        console.log('Default theme set to dark');
    } else {
        $('#root').attr('data-bs-theme', theme);
    }

    $(document).on('click', '#theme_btn', function () {
        let theme = localStorage.getItem('theme');

        if (theme === 'dark') {
            theme = 'light';
        } else {
            theme = 'dark';
        }

        localStorage.setItem('theme', theme);
        $('#root').attr('data-bs-theme', theme);
        console.log('Theme changed to', theme)
    });
};
```

[application.html.erb](app%2Fviews%2Flayouts%2Fapplication.html.erb)

```html

<html id="root" data-bs-theme="dark">
```

## Тесты

### Тест регистрации/входы/выхода

Генерируем интеграционные тесты для аутентификации
```shell
rails g integration_test authentication_pages --integration-tool=test_unit
```

Запускаем их
```shell
rake test TEST=test/integration/authentication_pages_test.rb
```

### Тест таблицы users

```shell
rake test TEST=test/controllers/users_controller_test.rb
```

### Тест таблицы people_finds

```shell
rake test TEST=test/controllers/people_finds_controller_test.rb
```

### Тест доступности страниц приложения

```shell
rake test TEST=test/controllers/avoidant_controller_test.rb
```

### Тесты страницы

Создаем файл `spec/test_avoidant_spec.rb`

Вставим код теста из Selenium Plugin. Вверху файла `test_avoidant_spec.rb` импортируем `require 'rails_helper'`, и заменяем `rspec` на `rspec-rails` в связи с тем, что для Rails rspec модуль свой.
Заменяем `${receiver}` на `@driver`

```shell
rails generate rspec:install
rails s
bundle exec rspec spec/test_avoidant_spec.rb
```

### Gemfile
```shell
gem 'bcrypt', '~> 3.1.7'
gem 'bootstrap'
gem 'font-awesome-sass'
gem 'jquery-rails'
gem 'rails-controller-testing'
gem 'rspec-rails'
gem 'rubocop', require: false
gem 'sassc-rails'
```

## Ошибки

```
Fix Completed 422 Unprocessable Entity
```

Добавляем в контроллер
`skip_before_action :verify_authenticity_token`

## Измененные файлы проекта

Копируем из 12 лабы:

- [layouts/_footer.html.erb](app%2Fviews%2Flayouts%2F_footer.html.erb)
- [layouts/_header.html.erb](app%2Fviews%2Flayouts%2F_header.html.erb)
- [layouts/_shim.html.erb](app%2Fviews%2Flayouts%2F_shim.html.erb)
- [views/sessions/session/new.html.erb](app%2Fviews%2Fsessions%2Fnew.html.erb)
- [views/sessions/destroy.html.erb](app%2Fviews%2Fsessions%2Fdestroy.html.erb)
- [app/helpers/sessions_helper.rb](app%2Fhelpers%2Fsessions_helper.rb)
- [views/users/new.html.erb](app%2Fviews%2Fusers%2Fnew.html.erb)

Правим:

- [layouts/application.html.erb](app%2Fviews%2Flayouts%2Fapplication.html.erb)
- [models/user.rb](app%2Fmodels%2Fuser.rb)
- [config/initializers/assets.rb](config%2Finitializers%2Fassets.rb)
- [config/importmap.rb](config%2Fimportmap.rb)
- [stylesheets/application.scss](app%2Fassets%2Fstylesheets%2Fapplication.scss)
- [routes.rb](config%2Froutes.rb)
- [controllers/users_controller.rb](app%2Fcontrollers%2Fusers_controller.rb)
- [app/controllers/application_controller.rb](app%2Fcontrollers%2Fapplication_controller.rb)
- [views/users/index.html.erb](app%2Fviews%2Fusers%2Findex.html.erb)
- [views/users/show.html.erb](app%2Fviews%2Fusers%2Fshow.html.erb)

Создаем:

- [avoidant/find.html.erb](app%2Fviews%2Favoidant%2Ffind.html.erb)
- [avoidant/home.html.erb](app%2Fviews%2Favoidant%2Fhome.html.erb)
- [avoidant/index.html.erb](app%2Fviews%2Favoidant%2Findex.html.erb)
- [avoidant/people.html.erb](app%2Fviews%2Favoidant%2Fpeople.html.erb)
- [javascript/src/main.js](app%2Fjavascript%2Fsrc%2Fmain.js)
- [stylesheets/custom.scss](app%2Fassets%2Fstylesheets%2Fcustom.scss)
