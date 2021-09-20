# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Ifsv
            # Happymapper implementation for the root object of an Response.
            class IfsvDependentVerification
              include HappyMapper
              register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

              tag 'IFSVDependentVerification'

              has_one :IFSVApplicantVerification, IfsvApplicantVerification

              def self.domain_to_mapper(dependent_verification)
                mapper = self.new
                mapper.IFSVApplicantVerification = dependent_verification.IFSVApplicantVerification

                mapper
              end
            end
          end
        end
      end
    end
  end
end
