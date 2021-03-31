# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Demographic.
      class DemographicContract < Dry::Validation::Contract
        include ::AcaEntities::AppHelper

        params do
          required(:is_applying_coverage).filled(:bool)
          required(:gender).filled(Types::GenderKind)
          required(:dob).filled(:date)
          optional(:ethnicity).array(:string)
          optional(:race).maybe(:string)
          optional(:is_veteran_or_active_military).maybe(:bool)
          optional(:is_vets_spouse_or_child).maybe(:bool)
        end

        rule(:is_veteran_or_active_military) do
          if key? && values[:is_applying_coverage] == true && check_if_blank?(value)
            # This field is mandatory if person is applying for coverage in the UI.
            # XSD validation: <xs:element name="is_veteran" type="xs:boolean"/>
            key.failure(text: 'cannot be blank')
          end
        end
      end
    end
  end
end
