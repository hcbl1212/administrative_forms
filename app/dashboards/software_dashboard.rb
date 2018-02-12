require "administrate/base_dashboard"

class SoftwareDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    system_access_request_softwares: Field::HasMany,
    system_access_requests: Field::HasMany,
    software_roles: Field::HasMany,
    roles: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :system_access_request_softwares,
    :system_access_requests,
    :software_roles,
    :roles,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :system_access_request_softwares,
    :system_access_requests,
    :software_roles,
    :roles,
    :id,
    :name,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :system_access_request_softwares,
    :system_access_requests,
    :software_roles,
    :roles,
    :name,
  ].freeze

  # Overwrite this method to customize how softwares are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(software)
  #   "Software ##{software.id}"
  # end
end
