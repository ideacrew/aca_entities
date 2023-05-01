# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity InsurancePolicy
      class InsurancePolicy < Dry::Struct
        attribute :InsuranceCoverages, Types::Array.of(AcaEntities::Fdsh::H36::InsuranceCoverage).meta(omittable: false)
      end
    end
  end
end
