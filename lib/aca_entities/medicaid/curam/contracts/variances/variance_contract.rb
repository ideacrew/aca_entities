# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Variances
        # contract for curam variance
        class VarianceContract < Curam::ApplicationContract

          params do
            required(:title).filled(:string)
            optional(:description).maybe(:string)
            required(:status).filled(:string)
            required(:status_result).filled(:string)
            required(:severity).filled(:string)
            optional(:assigned_to).maybe(:string)
            optional(:updated_by).maybe(:string)
            optional(:review_status).maybe(:string)
          end
        end
      end
    end
  end
end
