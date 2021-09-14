# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Ifsv
            # Happymapper implementation for the root object of an Request.
            class IfsvApplicant
              include HappyMapper
              register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

              tag 'IFSVApplicant'

              element :TaxpayerIdentificationNumber, String, tag: 'TaxpayerIdentificationNumber', namespace: 'irs'
              has_one :CompletePersonName, CompletePersonName
              element :FilerTypeCd, String, tag: 'FilerTypeCd', namespace: 'irs'

              def self.domain_to_mapper(applicant)
                mapper = self.new
                mapper.TaxpayerIdentificationNumber = applicant.TaxpayerIdentificationNumber
                mapper.CompletePersonName = CompletePersonName.domain_to_mapper(applicant.CompletePersonName)
                mapper.FilerTypeCd = applicant.FilerTypeCd

                mapper
              end
            end
          end
        end
      end
    end
  end
end
