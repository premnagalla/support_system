json.extract! request, :id, :title, :description, :status, :unique_id, :department_id, :requested_by, :updated_by, :created_at, :updated_at
json.url request_url(request, format: :json)