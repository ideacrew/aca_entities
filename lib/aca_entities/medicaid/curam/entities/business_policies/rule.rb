# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module BusinessPolicies
        # entity for business policy rule
        class Rule < Dry::Struct
          attribute :key,                 Types::String
          attribute :expression,          Types::Any # Pass Proc to entity or Create Proc Type for coersion
          attribute :success_message,     Types::Any
          attribute :failure_message,     Types::Any
          attribute :execution_order,     Types::Integer
        end
      end
    end
  end
end
