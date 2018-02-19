class Employee < ApplicationRecord
    has_many :system_access_requests, dependent: :destroy
    accepts_nested_attributes_for :system_access_requests
    validates :email, uniqueness: true
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :timeoutable

    after_create :assign_default_role

    enum role:  {
        admin: 1,
        manager: 2,
        sales_rep: 3,
        standard: 4
    }

    class << self
        def create_new_employee!(attributes)
            employee = Employee.new
            employee.employee = attributes['employee']
            employee.email = attributes['email']
            employee.first_name = attributes['first_name']
            employee.middle_initial = attributes['middle_initial']
            employee.last_name = attributes['last_name']
            employee.job_title = attributes['job_title']
            employee.save!(validate: false)
            employee
        end
    end


    def full_name
        [first_name, middle_initial, last_name].compact.reject(&:blank?).join(' ')
    end


    private

        def assign_default_role
            self.role = "standard" if self.role.to_s.empty?
            self.save(validate: false)
        end
end
