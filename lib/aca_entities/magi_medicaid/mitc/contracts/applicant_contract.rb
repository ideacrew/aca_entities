# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::Applicant}
        class ApplicantContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :person_id required
          # @option opts [Hash] :indian_tribe_member required
          # @option opts [String] :is_medicaid_eligible required
          # @option opts [String] :is_chip_eligible required
          # @option opts [Array] :medicaid_ineligibility_reasons required
          # @option opts [String] :is_eligible_for_non_magi_reasons required
          # @option opts [Array] :chip_ineligibility_reasons required
          # @option opts [String] :medicaid_category required
          # @option opts [Integer] :medicaid_category_threshold required
          # @option opts [Array] :physical_households required
          # @option opts [String] :chip_category required
          # @option opts [Integer] :chip_category_threshold required
          # @option opts [Hash] :category_determination required
          # @option opts [Array] :qualified_children required
          # @return [Dry::Monads::Result]
          params do
            required(:person_id).filled(:string)
            required(:medicaid_household).hash(MedicaidHouseholdContract.params)
            required(:is_medicaid_eligible).filled(Types::YesNoKind)
            required(:is_chip_eligible).filled(Types::YesNoKind)
            required(:medicaid_ineligibility_reasons).array(:string)
            required(:is_eligible_for_non_magi_reasons).filled(Types::YesNoKind)
            required(:chip_ineligibility_reasons).array(:string)
            required(:medicaid_category).filled(:string)
            required(:medicaid_category_threshold).filled(:integer)
            required(:chip_category).filled(:string)
            required(:chip_category_threshold).filled(:integer)
            required(:determinations).array(CategoryDeterminationContract.params)
            required(:other_output).hash(OtherOutputContract.params)
          end
        end
      end
    end
  end
end
