# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for VlpDocument
      class VlpDocumentContract < Dry::Validation::Contract

        params do
          optional(:subject).maybe(MagiMedicaid::Types::VlpDocumentKind)
          optional(:alien_number).maybe(:string)
          optional(:i94_number).maybe(:string)
          optional(:visa_number).maybe(:string)
          optional(:sevis_id).maybe(:string)
          optional(:naturalization_number).maybe(:string)
          optional(:receipt_number).maybe(:string)
          optional(:citizenship_number).maybe(:string)
          optional(:card_number).maybe(:string) # Not in verification.xsd
          optional(:country_of_citizenship).maybe(:string) # Not in verification.xsd
          optional(:passport_number).maybe(:string)
          optional(:expiration_date).maybe(:date)
          optional(:issuing_country).maybe(:string)
          optional(:description).maybe(:string)
        end
      end
    end
  end
end
