json.extract! employee, :id, :employee, :first_name, :last_name, :middle_initial, :job_title, :employee_email, :created_at, :updated_at
json.url employee_url(employee, format: :json)
