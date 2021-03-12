# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for IdentifyingInformation.
    class IdentifyingInformationContract < Dry::Validation::Contract

      params do
        optional(:ssn).maybe(:string)
        optional(:hbx_id).maybe(:string)
        optional(:medicaid_id).maybe(:string)
        optional(:chip_id).maybe(:string)
        optional(:primary_insured).maybe(:bool)
        optional(:temporary_id).maybe(:string)
      end

      rule(:medicaid_id) do
        if key?
          # At least one of Medicaid Person ID or CHIP Person ID
          # is required if sent from state to FFE.
        end
      end

      rule(:chip_id) do
        if key?
          # At least one of Medicaid Person ID or CHIP Person ID
          # is required if sent from state to FFE.
        end
      end
    end
  end
end
