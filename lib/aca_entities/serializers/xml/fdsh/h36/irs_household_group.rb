# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an IrsHouseholdGroup.
          class IrsHouseholdGroup
            include HappyMapper

            tag 'IRSHouseholdGrp'

            element :IrsGroupIdentificationNumber, String, tag: 'IRSGroupIdentificationNum'
            has_many :TaxHouseholds, TaxHousehold
            has_many :InsurancePolicies, InsurancePolicy

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.IrsGroupIdentificationNumber = request.IrsGroupIdentificationNumber
              mapper.TaxHouseholds = request.TaxHouseholds.collect do |tax_household|
                TaxHousehold.domain_to_mapper(tax_household)
              end
              mapper.InsurancePolicies = request.InsurancePolicies.collect do |insurance_policy|
                InsurancePolicy.domain_to_mapper(insurance_policy)
              end

              mapper
            end
          end
        end
      end
    end
  end
end