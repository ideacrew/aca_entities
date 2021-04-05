# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Attestation.
      class AttestationContract < Dry::Validation::Contract
        include ::AcaEntities::AppHelper

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
