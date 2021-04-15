# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ProductDeliveryCases
        # contract for ProductDeliveryCase
        class ProductDeliveryCaseContract < Curam::ApplicationContract

          params do
            required(:ids).array(:hash)
            required(:name).filled(Curam::TypesProductNameKind)
            required(:program_type).filled(Curam::TypesProductTypeKind)
          end
        end
      end
    end
  end
end
