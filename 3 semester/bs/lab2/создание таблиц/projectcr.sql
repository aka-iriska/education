create table project 
(project_no char(3) NOT NULL, -- шифр проекта
project_name text NOT NULL,--имя проекта
 project_complexity float not null, --трудоемкость
 deadline date not null, -- крайний срок
 primary key (project_no)
)