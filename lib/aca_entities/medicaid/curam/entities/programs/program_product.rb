# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Programs
        # Product programs
        class ProgramProduct
          PRODUCT_TYPE_TO_PROGRAM_TYPE = {
            "LIHEAP" => "Food Assistance",
            "LSS" => "Food Assistance",
            "Food Assistance" => "Food Assistance"
          }.freeze
        end
      end
    end
  end
end