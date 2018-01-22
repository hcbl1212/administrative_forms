class Software < ApplicationRecord
    has_many :software_roles
    has_many :roles, through: :software_roles
end
