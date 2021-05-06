# frozen_string_literal: true

module AcaEntities
  module Crms
    module SugarCrm
      module Contacts
        # contract for sugar_crm Contacts
        class ContactContract < ApplicationContract
          params do
            optional(:deleted).maybe(:string)
            optional(:do_not_call).maybe(:string)
            optional(:portal_active).maybe(:string)
            optional(:preferred_language).maybe(:string)
            optional(:assigned_user_id).maybe(:string)
            optional(:assigned_user_name).maybe(:string)
            optional(:salutation).maybe(:string)
            optional(:first_name).maybe(:string)
            optional(:last_name).maybe(:string)
            optional(:title).maybe(:string)
            optional(:department).maybe(:string)
            optional(:description).maybe(:string)

            optional(:team_name).array(:hash) do
              optional(:id).maybe(:string)
              optional(:name).maybe(:string)
              optional(:name_2).maybe(:string)
              optional(:primary).maybe(:bool)
            end

            optional(:phone_home).maybe(Crm::Types::PhoneNumber)
            optional(:phone_mobile).maybe(Crm::Types::PhoneNumber)
            optional(:phone_work).maybe(Crm::Types::PhoneNumber)
            optional(:phone_fax).maybe(Crm::Types::PhoneNumber)
            optional(:email).array(:hash)

            optional(:primary_address).maybe(Locations::Address)
            optional(:campaign_id).maybe(:string)
            optional(:campaign_name).maybe(:string)
          end
        end
      end
    end
  end
end