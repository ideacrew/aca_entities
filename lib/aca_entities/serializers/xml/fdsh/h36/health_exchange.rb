# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an HealthExchange.
          class HealthExchange
            include HappyMapper
            register_namespace 'xsi', "http://www.w3.org/2001/XMLSchema-instance"
            register_namespace 'n1', "urn:us:gov:treasury:irs:msg:monthlyexchangeperiodicdata"
            register_namespace 'irs', "urn:us:gov:treasury:irs:common"

            tag 'HealthExchange'
            namespace 'n1'

            element :SubmissionYr, String, tag: 'SubmissionYr', namespace: 'irs'
            element :SubmissionMonthNum, String, tag: 'SubmissionMonthNum',  namespace: 'irs'
            element :ApplicableCoverageYr, String, tag: 'ApplicableCoverageYr', namespace: 'irs'
            has_one :IndividualExchange, IndividualExchange, namespace: 'irs'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.SubmissionYr = request.SubmissionYr
              mapper.SubmissionMonthNum = request.SubmissionMonthNum
              mapper.ApplicableCoverageYr = request.ApplicableCoverageYr
              mapper.IndividualExchange = IndividualExchange.domain_to_mapper(request.IndividualExchange) if request.IndividualExchange

              mapper
            end
          end
        end
      end
    end
  end
end