# frozen_string_literal: true

module AcaEntities
  module Crm
    module Contacts
      # entity for crm contact
      class Contact < Dry::Struct

        attribute :id,                        Types::Coercible::Integer.optional.meta(omittable: true)
        attribute :user_id,                   Types::Coercible::Integer.optional.meta(omittable: true)
        attribute :account_id,                Types::Coercible::Integer.optional.meta(omittable: true)
        attribute :lead_id,                   Types::Coercible::Integer.optional.meta(omittable: true)
        attribute :assigned_to_id,            Types::Coercible::Integer.optional.meta(omittable: true)

        # attribute :contact_index_cases,       Types::Array.of(Contacts::ContactIndexCase).optional.meta(omittable: true)
        # attribute :contact_exposure_cases,    Types::Array.of(Contacts::ContactExposureCase).optional.meta(omittable: true)
        # attribute :absences,                  Types::Array.of(Absences::Absence).optional.meta(omittable: true)

        # attribute :subscribed_users,          Types::Array.of(Users::User).meta(omittable: true)

        # attribute :identifiers,               Types::Array.of(Identifiers::Ids).default([].freeze).meta(omitabble: true)
        # attribute :tasks,                     Types::Array.of(Tasks::Task).meta(omittable: true)
        attribute :addresses,                 Types::Array.of(AcaEntities::Locations::Address).meta(omittable: true)

        # attribute :consents,                  Types::Array.of(Consents::Consent).meta(omittable: true)

        # attribute :contact_opportunities,     Types::Array.of(Opportunities::Opportunity).meta(omittable: true)
        # attribute :opportunities,             Types::Array.of(Opportunities::Opportunity).meta(omittable: true)

        attribute :outreach_priority,         Types::Coercible::Integer.optional.meta(omittable: true)

        # User-defined category sets: e.g. faculty, staff, student - or - employees, customers
        attribute :category,                  Types::String.meta(omittable: true)

        attribute :first_name,                Types::Strict::String.meta(omittable: false)
        attribute :last_name,                 Types::Strict::String.meta(omittable: false)
        attribute :preferred_name,            Types::String.optional.meta(omittable: true)

        attribute :born_on,                   Types::Date.optional.meta(omittable: true)
        attribute :hired_on,                  Types::Date.optional.meta(omittable: true)
        attribute :ssn,                       Types::String.optional.meta(omittable: true)

        attribute :gender,                    Crm::Types::GenderKind.optional.meta(omittable: true)
        attribute :preferred_language,        Types::String.optional.meta(omittable: true)
        attribute :used_interpreter,          Crm::Types::YesNoUnknownKind.optional.meta(omittable: true)

        attribute :access,                    Types::String.optional.meta(omittable: true)
        attribute :title,                     Types::String.optional.meta(omittable: true)
        attribute :department,                Types::String.optional.meta(omittable: true)
        attribute :source,                    Types::String.optional.meta(omittable: true)
        attribute :reports_to,                Types::Coercible::Integer.optional.meta(omittable: true)

        attribute :email,                     Crm::Types::Email.optional.meta(omittable: true)
        attribute :alt_email,                 Crm::Types::Email.optional.meta(omittable: true)
        attribute :phone,                     Crm::Types::PhoneNumber.optional.meta(omittable: true)
        attribute :mobile,                    Crm::Types::PhoneNumber.optional.meta(omittable: true)

        attribute :linkedin,                  Types::String.optional.meta(omittable: true)
        attribute :facebook,                  Types::String.optional.meta(omittable: true)
        attribute :twitter,                   Types::String.optional.meta(omittable: true)
        attribute :do_not_call,               Types::Bool.optional.meta(omittable: true)
        attribute :background_info,           Types::String.optional.meta(omittable: true)

        attribute :tag_list,                  Types::Array.of(Types::String).optional.meta(omittable: true)

        attribute :created_at,                Types::DateTime.optional.meta(omittable: true)
        attribute :updated_at,                Types::DateTime.optional.meta(omittable: true)
        attribute :deleted_at,                Types::DateTime.optional.meta(omittable: true)

        def contact_cases
          []
        end

      end
    end
  end
end
