# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ProductDeliveryCases
        # contract for IntegratedCaseTransform
        class IntegratedCaseTransformContract < Curam::ApplicationContract

          params do
            required(:source_system_key).filled(:string)
            required(:ids).array(:hash) do
              required(:key).filled(:string)
              required(:item).filled(:string)
              optional(:kind).maybe(:string)
              optional(:start_on).maybe(:date_time)
              optional(:end_on).maybe(:date_time)
            end
            required(:product_delivery_cases).array(:hash)
          end

          rule(:product_delivery_cases) do
            if key? && value
              applications_array = value.inject([]) do |hash_array, appl_hash|
                if appl_hash.is_a?(Hash)
                  result = ::Curam::ProductDeliveryCases::ProductDeliveryCaseTransformContract.new.call(appl_hash)
                  if result&.failure?
                    key.failure(text: 'invalid product_delivery_case', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid product_delivery_case. Expected a hash.')
                end
                hash_array
              end
              values.merge!(product_delivery_cases: applications_array)
            end
          end
        end
      end
    end
  end
end