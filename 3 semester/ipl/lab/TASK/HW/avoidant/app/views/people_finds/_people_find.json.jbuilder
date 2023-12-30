json.extract! people_find, :id, :users_id, :address, :conditions, :gender, :age, :body_type, :height, :race, :facial_hair, :voice, :hair_color, :ears, :wrinkles, :forehead, :created_at, :updated_at
json.url people_finds_url(people_find, format: :json)
