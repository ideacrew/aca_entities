# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Attestation}
      class AttestationContract < Dry::Validation::Contract
        include ::AcaEntities::AppHelper
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_applying_coverage required
        # @option opts [Boolean] :is_incarcerated optional
        # @option opts [Boolean] :is_disabled required
        # @option opts [Boolean] :is_self_attested_long_term_care optional
        # @return [Dry::Monads::Result]
        params do
          required(:is_applying_coverage).filled(:bool)
          optional(:is_incarcerated).maybe(:bool)
          # is_self_attested_disabled
          required(:is_disabled).filled(:bool)
          optional(:is_self_attested_long_term_care).maybe(:bool)
        end

        rule(:is_incarcerated) do
          if values[:is_applying_coverage] && check_if_blank?(value)
            # This field is mandatory if person is applying for coverage in the UI.
            # XSD validation: <xs:element name="is_incarcerated" type="xs:boolean" minOccurs="0"/>
            key.failure(text: 'cannot be blank')
          end
        end
      end
    end
  end
end
