# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an InsurancePolicy.
          class InsurancePolicy
            include HappyMapper

            tag 'InsurancePolicy'

            has_many :InsuranceCoverages, InsuranceCoverage

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.InsuranceCoverages = request.InsuranceCoverages.collect do |coverage|
                InsuranceCoverage.domain_to_mapper(coverage)
              end

              mapper
            end
          end
        end
      end
    end
  end
end