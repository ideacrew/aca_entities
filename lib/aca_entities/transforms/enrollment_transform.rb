# frozen_string_literal: true

require 'dry/transformer/recursion'
require 'aca_entities/transforms/deep_nest'
# require 'aca_entities/transform_dsl/t_dsl'

module AcaEntities
  module Transforms
    class EnrollmentTransform < Dry::Transformer::Pipe
      import Dry::Transformer::ArrayTransformations
      import Dry::Transformer::HashTransformations
      import Dry::Transformer::Recursion
      import AcaEntities::Transforms::DeepNest

      define! do
        map_array do
          hash_recursion do
            deep_accept_keys [:policyTrackingNumber, :coveredInsuredMembers, :subscriberIndicator]
            deep_rename_keys subscriberIndicator: :isSubscriber, policyTrackingNumber: :hbxID, coveredInsuredMembers: :hbxEnrollmentMembers
            symbolize_keys
          end
          deep_map_keys
        end
      end
    end
  end
end
































