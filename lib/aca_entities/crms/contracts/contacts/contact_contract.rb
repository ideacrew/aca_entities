# frozen_string_literal: true

module AcaEntities
  module Crms
    module Contacts
      # contract for crm contact
      class ContactContract < AcaEntities::Contracts::Contract
        params do
          required(:hbx_id).filled(:string)
          required(:relationship_to_primary).filled(:string)
          optional(:identifiers).array(:hash)
          optional(:user).maybe(:hash)
          optional(:account_contact).maybe(:hash)
          # optional(:addresses).array(AcaEntities::Locations::Address)
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          optional(:preferred_name).maybe(:string)
          optional(:date_of_birth).maybe(:date)
          optional(:ssn).maybe(:string)
          optional(:gender).maybe(:string)
          optional(:preferred_language).maybe(:string)
          optional(:access).maybe(:string)
          optional(:title).maybe(:string)
          optional(:department).maybe(:string)
          optional(:source).maybe(:string)
          optional(:reports_to).maybe(:integer)
          optional(:email).maybe(:string)
          optional(:alt_email).maybe(:string)
          optional(:phone).maybe(:string)
          optional(:mobile).maybe(:string)
          optional(:do_not_call).maybe(:bool)
          optional(:background_info).maybe(:string)

          optional(:created_at).maybe(:date_time)
          optional(:updated_at).maybe(:date_time)
          optional(:deleted_at).maybe(:date_time)
        end
      end
    end
  end
end
