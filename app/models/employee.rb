class Employee < ApplicationRecord
    has_many :system_access_requests, dependent: :destroy
    accepts_nested_attributes_for :system_access_requests
    validates :employee_email, uniqueness: true
    validates :first_name, :last_name, :employee, presence: true
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :timeoutable

    class << self
        def create_new_employee!(attributes)
            employee = Employee.new
            employee.employee = attributes[:employee]
            employee.employee_email = attributes[:employee_email]
            employee.first_name = attributes[:first_name]
            employee.middle_initial = attributes[:middle_initial]
            employee.last_name = attributes[:last_name]
            employee.job_title = attributes[:job_title]
            employee.save!
            employee
        end
    end
end
