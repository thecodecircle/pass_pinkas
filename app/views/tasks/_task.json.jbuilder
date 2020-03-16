json.extract! task, :id, :name, :score, :description, :publicity, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
