# frozen_string_literal: true

module Maps
  module PostGis

    # Schema and validation rules for the {Maps::PostGis::AssignPolyColumnToPoint} operation
    # @!method call(opts)
    # @param [Hash] opts the parameters to validate using this contract
    # @option opts [String] :polygon_table_name required
    # @option opts [String] :polygon_spatial_column_name required
    # @option opts [String] :polygon_assignment_column_name required
    # @option opts [String] :point_table_name required
    # @option opts [String] :point_spatial_column_name required
    # @return [Dry::Monads::Result] if params pass validation
    class AssignPolyColumnToPointContract < ApplicationContract

      params do
        required(:polygon_table_name).filled(:string)
        required(:polygon_spatial_column_name).filled(:string)
        required(:polygon_assignment_column_name).filled(:string)
        required(:point_table_name).filled(:string)
        required(:point_spatial_column_name).filled(:string)
      end

    end
  end
end
