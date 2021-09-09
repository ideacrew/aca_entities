# frozen_string_literal: true

module AcaEntities
  module Crms
    # To be used in CRM Gateway and elsewhere
    module Contacts
      # Domain entity for CRM Contract Entity
      class Contact < Dry::Struct
        attribute :primary_person_hbx_id, Types::String.optional.meta(omittable: true)
        attribute :id, Types::Coercible::Integer.optional.meta(omittable: true)
        attribute :user_id,
                  Types::Coercible::Integer.optional.meta(omittable: true)
        attribute :account_id,
                  Types::Coercible::Integer.optional.meta(omittable: true)
        attribute :lead_id,
                  Types::Coercible::Integer.optional.meta(omittable: true)
        attribute :assigned_to_id,
                  Types::Coercible::Integer.optional.meta(omittable: true)

        attribute :addresses,
                  Types::Array.of(Locations::Address).meta(omittable: true)

        # attribute :consents,                  Types::Array.of(Consents::Consent).meta(omittable: true)

        attribute :first_name, Types::Strict::String.meta(omittable: false)
        attribute :last_name, Types::Strict::String.meta(omittable: false)
        attribute :preferred_name, Types::String.optional.meta(omittable: true)

        attribute :born_on, Types::Date.optional.meta(omittable: true)
        attribute :hired_on, Types::Date.optional.meta(omittable: true)
        attribute :ssn, Types::String.optional.meta(omittable: true)

        attribute :relationship_to_primary,
                  Types::String.optional.meta(omittable: true)
        attribute :preferred_language,
                  Types::String.optional.meta(omittable: true)
        attribute :email, Types::String.optional.meta(omittable: true)
        attribute :alt_email, Types::String.optional.meta(omittable: true)
        attribute :phone, Types::String.optional.meta(omittable: true)
        attribute :mobile, Types::String.optional.meta(omittable: true)

        attribute :created_at, Types::DateTime.optional.meta(omittable: true)
        attribute :updated_at, Types::DateTime.optional.meta(omittable: true)
        attribute :deleted_at, Types::DateTime.optional.meta(omittable: true)

        def contact_cases
          []
        end
      end
    end
  end
end
