json.extract! child, :id, :baby_name, :parent_name, :date_of_birth, :gender, :phone_number, :weight, :created_at, :updated_at
json.url child_url(child, format: :json)
