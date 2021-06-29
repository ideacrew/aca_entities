# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for ContactInformation.
      class ContactInformationContract < Dry::Validation::Contract

        params do
          optional(:contact_email_id).maybe(:string)
          optional(:mailing_address).maybe(:hash)
          optional(:telephone_number).maybe(:hash)
        end
      end
    end
  end
end
