# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Documents
      # Schema and validation rules for {AcaEntities::Documents::VlpDocumentContract}
      class VlpDocumentContract < Documents::DocumentContract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :alien_number optional
        # @option opts [String] :i94_number optional
        # @option opts [String] :visa_number optional
        # @option opts [String] :passport_number optional
        # @option opts [String] :sevis_id optional
        # @option opts [String] :naturalization_number optional
        # @option opts [String] :receipt_number optional
        # @option opts [String] :citizenship_number optional
        # @option opts [String] :card_number optional
        # @option opts [String] :country_of_citizenship optional
        # @option opts [Date] :expiration_date optional
        # @option opts [String] :issuing_country optional
        # @option opts [String] :status optional
        # @option opts [String] :verification_type optional
        # @option opts [String] :comment optional
        # @return [Dry::Monads::Result]
        params do
          optional(:alien_number).maybe(:string, size?: 9)
          optional(:i94_number).maybe(:string, size?: 11)
          optional(:visa_number).maybe(:string, size?: 8)
          optional(:passport_number).maybe(:string, size?: 6..12)
          optional(:sevis_id).maybe(:string, size?: 10)
          optional(:naturalization_number).maybe(:string, size?: 6..12)
          optional(:receipt_number).maybe(:string, size?: 13)
          optional(:citizenship_number).maybe(:string, size?: 6..12)
          optional(:card_number).maybe(:string, size?: 13)
          optional(:country_of_citizenship).maybe(:string)
          optional(:expiration_date).value(:date?)
          optional(:issuing_country).maybe(:string)
          optional(:status).maybe(:string)
          optional(:verification_type).maybe(:string)
          optional(:comment).maybe(:string)
        end
      end
    end
  end
end
