json.extract! chatroom, :id, :name, :created_at, :updated_at
json.url chatroom_url(chatroom, format: :json)
