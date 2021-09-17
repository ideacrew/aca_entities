# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          # Happymapper implementation for the root object of a NonEsiMecRequest.
          class NonEsiMecRequest
            include HappyMapper

            tag 'NonESIMECRequest'
            namespace 'gov'

            # 
            has_one :non_esi_mec_individual_information, NonEsiMecIndividualInformation

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.non_esi_mec_individual_information = NonEsiMecIndividualInformation.domain_to_mapper(request.non_esi_mec_individual_information)
              mapper
            end

            def to_hash()
              {
                non_esi_mec_individual_information: transfer_header.to_hash,
              }
            end
          end
        end
      end
    end
  end
end