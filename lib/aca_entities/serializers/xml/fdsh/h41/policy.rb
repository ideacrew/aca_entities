# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class Policy
            include HappyMapper
            register_namespace 'airty20a', "urn:us:gov:treasury:irs:ext:aca:air:ty20a"

            tag 'Policy'
            namespace 'airty20a'

            element :MarketPlacePolicyNum, String, tag: 'MarketPlacePolicyNum'
            element :PolicyIssuerNm, String, tag: 'PolicyIssuerNm'
            element :PolicyStartDt, String, tag: 'PolicyStartDt'
            element :PolicyTerminationDt, String, tag: 'PolicyTerminationDt'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.MarketPlacePolicyNum = request.MarketPlacePolicyNum
              mapper.PolicyIssuerNm = request.PolicyIssuerNm
              mapper.PolicyStartDt = request.PolicyStartDt
              mapper.PolicyTerminationDt = request.PolicyTerminationDt if request.PolicyTerminationDt

              mapper
            end
          end
        end
      end
    end
  end
end
