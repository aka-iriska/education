json.extract! user, :id, :email, :password_digest, :remember_token, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)
