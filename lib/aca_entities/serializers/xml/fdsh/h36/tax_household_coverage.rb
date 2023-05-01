# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an TaxHouseholdCoverage.
          class TaxHouseholdCoverage
            include HappyMapper

            tag 'TaxHouseholdCoverage'

            element :ApplicableCoverageMonthNum, String, tag: "ApplicableCoverageMonthNum"
            has_one :Household, Household
            has_one :OtherRelevantAdult, OtherRelevantAdult

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.ApplicableCoverageMonthNum = request.ApplicableCoverageMonthNum
              mapper.Household = Household.domain_to_mapper(request.Household) if request.Household
              mapper.OtherRelevantAdult = OtherRelevantAdult.domain_to_mapper(request.OtherRelevantAdult) if request.OtherRelevantAdult

              mapper
            end
          end
        end
      end
    end
  end
end