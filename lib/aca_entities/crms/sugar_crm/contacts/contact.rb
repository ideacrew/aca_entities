# frozen_string_literal: true

module AcaEntities
  module Crms
    module SugarCrm
      module Contacts
        # entity for sugar_crm Contacts
        class Contact < Dry::Struct

          attribute :deleted,              Types::Strict::String.meta(omittable: true)
          attribute :do_not_call,          Types::Strict::String.meta(omittable: true)
          attribute :portal_active,        Types::Strict::String.meta(omittable: true)
          attribute :preferred_language,   Types::Strict::String.meta(omittable: true)
          attribute :assigned_user_id,     Types::Strict::String.meta(omittable: true)
          attribute :assigned_user_name,   Types::Strict::String.meta(omittable: true)
          attribute :salutation,           Types::Strict::String.meta(omittable: true)
          attribute :first_name,           Types::Strict::String.meta(omittable: true)
          attribute :last_name,            Types::Strict::String.meta(omittable: true)
          attribute :title,                Types::Strict::String.meta(omittable: true)
          attribute :department,           Types::Strict::String.meta(omittable: true)
          attribute :description,          Types::Strict::String.meta(omittable: true)

          attribute :team_name, Types::Array do
            attribute :id,      Types::Strict::String.meta(omittable: true)
            attribute :name,    Types::Strict::String.meta(omittable: true)
            attribute :name_2,  Types::Strict::String.meta(omittable: true)
            attribute :primary, Types::Bool.meta(omittable: true)
          end

          attribute :phone_home,            Crm::Types::PhoneNumber.meta(omittable: true)
          attribute :phone_mobile,          Crm::Types::PhoneNumber.meta(omittable: true)
          attribute :phone_work,            Crm::Types::PhoneNumber.meta(omittable: true)
          attribute :phone_fax,             Crm::Types::PhoneNumber.meta(omittable: true)
          attribute :email,                 Types::Array.of(Emails::Email).meta(omittable: true)

          attrubute :primary_address,       Locations::Address.meta(omittable: true)

          attribute :campaign_id,           Types::Strict::String.meta(omittable: true)
          attribute :campaign_name,         Types::Strict::String.meta(omittable: true)

        end
      end
    end
  end
end