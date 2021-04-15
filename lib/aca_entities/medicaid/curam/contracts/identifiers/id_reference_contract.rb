# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Identifiers
        # contract for IdReference
        class IdReferenceContract < Curam::ApplicationContract
          params do
            optional(:source_system_key).maybe(:string)
            required(:ids).array(:hash) do
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
end
