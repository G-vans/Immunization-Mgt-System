json.extract! educational_message, :id, :title, :content, :category, :duration, :medic_id, :created_at, :updated_at
json.url educational_message_url(educational_message, format: :json)
