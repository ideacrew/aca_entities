# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an IndividualExchange.
          class IndividualExchange
            include HappyMapper
            register_namespace 'irs', "urn:us:gov:treasury:irs:common"

            tag 'IndividualExchange'
            namespace 'irs'

            element :HealthExchangeId, String, tag: 'HealthExchangeId'
            has_one :IrsHouseholdGroup, IrsHouseholdGroup, namespace: 'irs'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.HealthExchangeId = request.HealthExchangeId
              mapper.IrsHouseholdGroup = IrsHouseholdGroup.domain_to_mapper(request.IrsHouseholdGroup) if request.IrsHouseholdGroup

              mapper
            end
          end
        end
      end
    end
  end
end