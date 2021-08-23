# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # Request.
            class SSACompositeIndividualRequest
              include HappyMapper
              register_namespace 'ssac', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'SSACompositeIndividualRequest'
              namespace 'ssac'

              has_one :Person, Person
              element :RequestCitizenshipVerificationIndicator, Boolean, tag: 'RequestCitizenshipVerificationIndicator', namespace: "ssac"
              element :RequestIncarcerationVerificationIndicator, Boolean, tag: 'RequestIncarcerationVerificationIndicator', namespace: "ssac"
              element :RequestTitleIIMonthlyIncomeVerificationIndicator, Boolean, tag: 'RequestTitleIIMonthlyIncomeVerificationIndicator',
                                                                                  namespace: "ssac"
              element :RequestTitleIIAnnualIncomeVerificationIndicator, Boolean, tag: 'RequestTitleIIAnnualIncomeVerificationIndicator',
                                                                                 namespace: "ssac"
              element :RequestQuartersOfCoverageVerificationIndicator, Boolean, tag: 'RequestQuartersOfCoverageVerificationIndicator',
                                                                                namespace: "ssac"
              element :RequestTitleIIMonthlyIncomeDate, Date, tag: 'RequestTitleIIMonthlyIncomeDate', namespace: "ssac"
              element :RequestTitleIIAnnualIncomeDate, Date, tag: 'RequestTitleIIAnnualIncomeDate', namespace: "ssac"

              def self.domain_to_mapper(initial_request_set)
                mapper = self.new

                mapper.Person = Person.domain_to_mapper(initial_request_set.Person)
                mapper.RequestCitizenshipVerificationIndicator = initial_request_set.RequestCitizenshipVerificationIndicator
                mapper.RequestIncarcerationVerificationIndicator = initial_request_set.RequestIncarcerationVerificationIndicator
                mapper.RequestTitleIIMonthlyIncomeVerificationIndicator = initial_request_set.RequestTitleIIMonthlyIncomeVerificationIndicator
                mapper.RequestTitleIIAnnualIncomeVerificationIndicator = initial_request_set.RequestTitleIIAnnualIncomeVerificationIndicator
                mapper.RequestQuartersOfCoverageVerificationIndicator = initial_request_set.RequestQuartersOfCoverageVerificationIndicator
                mapper.RequestTitleIIMonthlyIncomeDate = initial_request_set.RequestTitleIIMonthlyIncomeDate&.strftime
                mapper.RequestTitleIIAnnualIncomeDate = initial_request_set.RequestTitleIIAnnualIncomeDate&.strftime

                mapper
              end
            end
          end
        end
      end
    end
  end
end