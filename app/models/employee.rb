class Employee < ApplicationRecord
    has_many :system_access_requests, dependent: :destroy
    accepts_nested_attributes_for :system_access_requests
    validates :email, uniqueness: true
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :timeoutable

    class << self
        def create_new_employee!(attributes)
            employee = Employee.new
            employee.employee = attributes[:employee]
            employee.email = attributes[:email]
            employee.first_name = attributes[:first_name]
            employee.middle_initial = attributes[:middle_initial]
            employee.last_name = attributes[:last_name]
            employee.job_title = attributes[:job_title]
            employee.save!(validate: false)
            employee
        end
    end
end
