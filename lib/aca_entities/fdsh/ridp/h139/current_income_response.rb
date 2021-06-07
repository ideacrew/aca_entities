# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for CurrentIncomeResponse
        class CurrentIncomeResponse < Dry::Struct

          attribute :request_number,   Types::String.meta(omittable: false)

        end
      end
    end
  end
end