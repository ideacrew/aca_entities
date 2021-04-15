# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ProductDeliveryCases
        # contract for ProductDeliveryCaseTransform
        class ProductDeliveryCaseTransformContract < Curam::ApplicationContract

          params do
            required(:source_system_key).filled(:string)
            required(:ids).array(:hash) do
              required(:key).filled(:string)
              required(:item).filled(:string)
              optional(:kind).maybe(:string)
              optional(:start_on).maybe(:date_time)
              optional(:end_on).maybe(:date_time)
            end
            required(:case_reference).filled(:string)
            required(:last_updated_at).filled(:date_time)
          end
        end
      end
    end
  end
end
