# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an TaxHousehold.
          class TaxHousehold
            include HappyMapper

            tag 'TaxHousehold'

            has_many :TaxHouseholdCoverages, TaxHouseholdCoverage

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.TaxHouseholdCoverages = request.TaxHouseholdCoverages.collect do |thh_coverage|
                TaxHouseholdCoverage.domain_to_mapper(thh_coverage)
              end

              mapper
            end
          end
        end
      end
    end
  end
end