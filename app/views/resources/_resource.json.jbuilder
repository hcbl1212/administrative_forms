json.extract! resource, :id, :name, :url, :resource_type, :created_at, :updated_at
json.url resource_url(resource, format: :json)
