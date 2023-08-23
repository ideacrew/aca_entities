# frozen_string_literal: true

module AcaEntities
  module Cms
    module Pbp
      module Contracts
        # Schema and validation rules for the {Cms::Pbp::FinancialInformation} domain model
        class FinancialInformationContract < Dry::Validation::Contract
          params do
            required(:financial_effective_start_date).filled(:date)
            required(:financial_effective_end_date).filled(:date)
            required(:monthly_premium_amount).filled(AcaEntities::Types::Money)
            optional(:monthly_aptc_amount).maybe(AcaEntities::Types::Money)
            required(:monthly_responsible_amount).filled(AcaEntities::Types::Money)
            optional(:monthly_csr_amount).maybe(AcaEntities::Types::Money)
            optional(:csr_variant).maybe(:string)
            optional(:rating_area).maybe(:string)
            optional(:prorated_amounts).array(AcaEntities::Cms::Pbp::Contracts::ProratedAmountContract.params)
          end
        end
      end
    end
  end
end
