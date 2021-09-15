# frozen_string_literal: true

require_relative "../../crms/contacts/contact"

module AcaEntities
  module Crms
    module Accounts
      # entity for crm accounts
      class Account < Dry::Struct
        # attribute :user, Users::User.optional.meta(omittable: true)
        # attribute :assigned_to, Users::User.optional.meta(omittable: true)
        # attribute :subscribed_users, Types::Array.of(Users::User).meta(omittable: true)

        # attribute :managing_division, Dry::Struct.meta(omittable: true) do
        #   attribute :division,   Accounts::Account.meta(omittable: true)
        # end

        attribute :name, Types::Strict::String.meta(omittable: false)
        attribute :addresses,
                  Types::Array
                    .of(AcaEntities::Locations::Address)
                    .meta(omittable: true)
        attribute :contacts, Types::Array.of(AcaEntities::Crms::Contacts::Contact).meta(omittable: true)
        attribute :email, Types::String.meta(omittable: true)
        attribute :phone, Types::String.meta(omittable: true)
        attribute :fax, Types::String.meta(omittable: true)

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
