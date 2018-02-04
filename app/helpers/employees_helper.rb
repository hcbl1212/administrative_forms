module EmployeesHelper
    def required_field(message='This Field Is Required.')
        "<sup><i class='material-icons tiny required' data-position='top' data-delay='50' data-tooltip='#{message}'>warning</i></sup>"
    end
end
