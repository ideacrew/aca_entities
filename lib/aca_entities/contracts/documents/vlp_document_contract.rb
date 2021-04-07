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
          optional(:alien_number).maybe(:string)
          optional(:i94_number).maybe(:string)
          optional(:visa_number).maybe(:string)
          optional(:passport_number).maybe(:string)
          optional(:sevis_id).maybe(:string)
          optional(:naturalization_number).maybe(:string)
          optional(:receipt_number).maybe(:string)
          optional(:citizenship_number).maybe(:string)
          optional(:card_number).maybe(:string)
          optional(:country_of_citizenship).maybe(:string)
          optional(:expiration_date).maybe(:date)
          optional(:issuing_country).maybe(:string)
          optional(:status).maybe(:string)
          optional(:verification_type).maybe(:string)
          optional(:comment).maybe(:string)
        end

        rule(:alien_number) do
          if key? && values[:alien_number]
            key.failure('Not a valid alien_number') unless values[:alien_number].length != 9
          end
        end

        rule(:citizenship_number) do
          if key? && values[:citizenship_number]
            key.failure('Not a valid citizenship_number') unless (6..12).cover?(values[:citizenship_number].length)
          end
        end

        rule(:i94_number) do
          if key? && values[:i94_number]
            key.failure('Not a valid i94_number') unless values[:i94_number].length != 11
          end
        end

        rule(:naturalization_number) do
          if key? && values[:naturalization_number]
            key.failure('Not a valid naturalization_number') unless (6..12).cover?(values[:naturalization_number].length)
          end
        end

        rule(:passport_number) do
          if key? && values[:passport_number]
            key.failure('Not a valid passport_number') unless (6..12).cover?(values[:passport_number].length)
          end
        end

        rule(:sevis_id) do
          if key? && values[:sevis_id]
            key.failure('Not a valid sevis_id') unless values[:sevis_id].length != 10
          end
        end

        rule(:visa_number) do
          if key? && values[:visa_number]
            key.failure('Not a valid visa_number') unless values[:visa_number].length != 8
          end
        end

        rule(:receipt_number) do
          if key? && values[:receipt_number]
            key.failure('Not a valid receipt_number') unless values[:receipt_number].length != 13
          end
        end

        rule(:card_number) do
          if key? && values[:card_number]
            key.failure('Not a valid card_number') unless values[:card_number].length != 13
          end
        end
      end
    end
  end
end
