json.extract! employee, :id, :employee, :first_name, :last_name, :middle_initial, :job_title, :email, :created_at, :updated_at
json.url employee_url(employee, format: :json)
