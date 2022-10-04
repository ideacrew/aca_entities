# frozen_string_literal: true

module AcaEntities
  module Products
    # external dependencies
    require 'aca_entities/organizations/organizations'
    require 'aca_entities/transitions/transitions'

    require_relative 'contracts/product_reference_contract'

    require_relative 'product'
    require_relative 'product_reference'
  end
end
