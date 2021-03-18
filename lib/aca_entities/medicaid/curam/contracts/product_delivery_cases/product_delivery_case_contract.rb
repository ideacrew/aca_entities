# frozen_string_literal: true

module Ehs
  module ProductDeliveryCases
    class ProductDeliveryCaseContract < Ehs::ApplicationContract

      params do
        required(:ids).array(:hash)
        required(:name).filled(Ehs::Types::ProductNameKind)
        required(:program_type).filled(Ehs::Types::ProductTypeKind)
      end
    end
  end
end
