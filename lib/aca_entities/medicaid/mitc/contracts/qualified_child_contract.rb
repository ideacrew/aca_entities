# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Mitc
      module Contracts
        # Contract for QualifiedChild.
        class QualifiedChildContract < Dry::Validation::Contract

          params do
            required(:person_id).filled(:integer)
            required(:determination).filled(:hash)
            required(:deprived_child).filled(:hash)
            required(:relationship).filled(:hash)
          end

          rule(:determination) do
            if key? && value
              if value.is_a?(Hash)
                result = CategoryDeterminationContract.new.call(value)
                if result&.failure?
                  key.failure(text: 'invalid determination', error: result.errors.to_h)
                else
                  values.merge!(determination: result.to_h)
                end
              else
                key.failure(text: 'invalid determination. Expected a hash.')
              end
            end
          end

          rule(:deprived_child) do
            if key? && value
              if value.is_a?(Hash)
                result = DeprivedChildContract.new.call(value)
                if result&.failure?
                  key.failure(text: 'invalid deprived_child', error: result.errors.to_h)
                else
                  values.merge!(deprived_child: result.to_h)
                end
              else
                key.failure(text: 'invalid deprived_child. Expected a hash.')
              end
            end
          end

          rule(:relationship) do
            if key? && value
              if value.is_a?(Hash)
                result = RelationshipContract.new.call(value)
                if result&.failure?
                  key.failure(text: 'invalid relationship', error: result.errors.to_h)
                else
                  values.merge!(relationship: result.to_h)
                end
              else
                key.failure(text: 'invalid relationship. Expected a hash.')
              end
            end
          end
        end
      end
    end
  end
end
