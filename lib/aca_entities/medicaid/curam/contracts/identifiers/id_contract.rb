# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Identifiers
        # contracts for Identifiers
        class IdContract < Curam::ApplicationContract
          params do
            required(:key).filled(:string)
            required(:item).filled(:string)
            optional(:kind).maybe(:string)
            optional(:start_on).maybe(:date_time)
            optional(:end_on).maybe(:date_time)
          end
        end
      end
    end
  end
end
