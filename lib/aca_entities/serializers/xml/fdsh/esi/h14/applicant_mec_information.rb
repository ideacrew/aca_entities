# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an Applicant MEC Information.
            class ApplicantMecInformation
              include HappyMapper
              register_namespace 'ext', 'http://vesim.dsh.cms.gov/extension/1.0'
              register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

              tag 'ApplicantMECInformation'
              namespace 'ext'

              has_one :InsuranceApplicantResponse, InsuranceApplicantResponse
              element :InconsistencyIndicator, Boolean, tag: 'InconsistencyIndicator', namespace: 'hix-core'
              has_one :MonthlyPremiumAmount, MonthlyPremiumAmount

              def self.domain_to_mapper(mec_information)
                mapper = self.new
                mapper.InsuranceApplicantResponse = InsuranceApplicantResponse.domain_to_mapper(mec_information.InsuranceApplicantResponse)
                mapper.InconsistencyIndicator = mec_information.InconsistencyIndicator
                if mec_information.MonthlyPremiumAmount
                  mapper.MonthlyPremiumAmount = MonthlyPremiumAmount.domain_to_mapper(mec_information.MonthlyPremiumAmount)
                end

                mapper
              end
            end
          end
        end
      end
    end
  end
end
