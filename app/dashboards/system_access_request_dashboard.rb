require "administrate/base_dashboard"

class SystemAccessRequestDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    employee: Field::BelongsTo,
    system_access_request_departments: Field::HasMany,
    departments: Field::HasMany,
    system_access_request_groups: Field::HasMany,
    groups: Field::HasMany,
    system_access_request_softwares: Field::HasMany,
    softwares: Field::HasMany,
    system_access_request_system_access_fields: Field::HasMany,
    system_access_fields: Field::HasMany,
    signatures: Field::HasMany,
    id: Field::Number,
    effective_date: Field::DateTime,
    reason: Field::String,
    privileged_access: Field::String,
    business_justification: Field::String,
    special_instructions: Field::String,
    other_access: Field::String,
    sales_rep_email: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    state: Field::String.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :employee,
    :reason,
    :state,
    :effective_date,
    :created_at,
    :signatures
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :employee,
    :system_access_request_departments,
    :departments,
    :system_access_request_groups,
    :groups,
    :system_access_request_softwares,
    :softwares,
    :system_access_request_system_access_fields,
    :system_access_fields,
    :signatures,
    :id,
    :effective_date,
    :reason,
    :privileged_access,
    :business_justification,
    :special_instructions,
    :other_access,
    :sales_rep_email,
    :created_at,
    :updated_at,
    :state,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :employee,
    :system_access_request_departments,
    :departments,
    :system_access_request_groups,
    :groups,
    :system_access_request_softwares,
    :softwares,
    :system_access_request_system_access_fields,
    :system_access_fields,
    :signatures,
    :effective_date,
    :reason,
    :privileged_access,
    :business_justification,
    :special_instructions,
    :other_access,
    :sales_rep_email,
    :state,
  ].freeze

  # Overwrite this method to customize how system access requests are displayed
  # across all pages of the admin dashboard.
  #
   def display_resource(system_access_request)
     "#{system_access_request.state}"
   end
end
