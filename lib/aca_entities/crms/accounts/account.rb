# frozen_string_literal: true

# Added

# attribute :division_name,       Types::String.meta(omittable: true)   # HQ, Region, Agency, Department
# attribute :contacts,            Accounts::AccountContact.optional.meta(omittable: true)
# attribute :website,             Types::String.meta(omittable: true)
# attribute :fax,                 Crm::Types::PhoneNumber.meta(omittable: true)
# attribute :addresses,           Types::Array.of(Locations::Address).meta(omittable: true)
# attribute :facility,            Facilities::Facility.optional.meta(omittable: true)
# attribute :opportunities,       Accounts::AccountsOpportunities.optional.meta(omittable: true)
# attribute :facility,            Facilities::Facility.optional.meta(omittable: true)

# Dropped

# attribute :lead,                Leads::Lead.optional.meta(omittable: true)
# attribute :mobile,              Crm::Types::PhoneNumber.meta(omittable: true)
# attribute :alt_email,           Crm::Types::Email.meta(omittable: true)
# attribute :date_of_birth,       Types::Date.meta(omittable: true)
# attribute :title,               Types::String.meta(omittable: true)
# attribute :department,          Types::String.meta(omittable: true)
# attribute :source,              Types::String.meta(omittable: true)
# attribute :do_not_call,         Types::Bool.meta(omittable: true)

module AcaEntities
  module Crms
    module Accounts
      # entity for crm accounts
      class Account < Dry::Struct
        attribute :user, Users::User.optional.meta(omittable: true)
        attribute :assigned_to, Users::User.optional.meta(omittable: true)
        attribute :access, Types::String.meta(omittable: true)
        attribute :subscribed_users,
                  Types::Array.of(Users::User).meta(omittable: true)

        # attribute :managing_division, Dry::Struct.meta(omittable: true) do
        #   attribute :division,   Accounts::Account.meta(omittable: true)
        # end

        attribute :name, Types::Strict::String.meta(omittable: false)
        attribute :division_name, Types::String.meta(omittable: true) # HQ, Region, Agency, Department
        attribute :division_kind, Types::String.meta(omittable: true) # HQ, Region, Agency, Department
        attribute :managing_division,
                  Accounts::Account.optional.meta(omittable: true)

        # attribute :divisions,           Types::Array.of(Accounts::Account).optional.meta(omittable: true)
        # attribute :contacts,            Types::Array.of(Accounts::AccountContracts).optional.meta(omittable: true)
        # attribute :opportunities, Accounts::AccountsOpportunities.optional.meta(omittable: true)

        # attribute :facility, Facilities::Facility.optional.meta(omittable: true)

        attribute :addresses,
                  Types::Array
                    .of(AcaEntities::Locations::Address)
                    .meta(omittable: true)
        attribute :email, Crm::Types::Email.meta(omittable: true)
        attribute :phone, Crm::Types::PhoneNumber.meta(omittable: true)
        attribute :fax, Crm::Types::PhoneNumber.meta(omittable: true)

        attribute :website, Types::String.meta(omittable: true)
        attribute :linkedin, Types::String.meta(omittable: true)
        attribute :facebook, Types::String.meta(omittable: true)
        attribute :twitter, Types::String.meta(omittable: true)
        attribute :category, Types::String.meta(omittable: true)

        attribute :contacts_count,
                  Types::Coercible::Integer.meta(omittable: false)
        attribute :opportunities_count,
                  Types::Coercible::Integer.meta(omittable: false)

        attribute :background_info, Types::String.meta(omittable: true)

        attribute :created_at, Types::DateTime.meta(omittable: true)
        attribute :updated_at, Types::DateTime.meta(omittable: true)
        attribute :deleted_at, Types::DateTime.meta(omittable: true)
      end
    end
  end
end
