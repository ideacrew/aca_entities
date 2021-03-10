# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for CoverageSpecificInformation.
    class CoverageSpecificInformationContract < Dry::Validation::Contract

      params do
        optional(:coverage_type_code).maybe(Types::CoverageTypeCode)
        optional(:total_premium).maybe(:float)
        optional(:aptc).maybe(:float)
        optional(:net_premium).maybe(:float)
        optional(:qhp_issuer_id).maybe(:string)
        optional(:qhp_id).maybe(:string)
        optional(:metal_level_code).maybe(Types::MetalLevelCode)
        optional(:issuer_name).maybe(:string)
        optional(:plan_name).maybe(:string)
      end

      rule(:coverage_type_code) do
        if key? && values[:coverage_type_code] == 'QHP'
          key.failure(text: 'qhp_issuer_id must be populated.') if values[:qhp_issuer_id].to_s.blank?
          key.failure(text: 'qhp_id must be populated.') if values[:qhp_id].to_s.blank?
        end
      end
    end
  end
end
