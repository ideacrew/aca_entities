# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class ApplicantVerification
              include HappyMapper
              register_namespace 'ext', 'http://ifsv.dsh.cms.gov/extension/1.0'

              tag 'ApplicantVerification'
              namespace 'ext'

              has_one :TaxReturn, TaxReturn
              has_many :ResponseMetadata, ResponseMetadata

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.TaxReturn = TaxReturn.domain_to_mapper(response.TaxReturn)
                mapper.ResponseMetadata = request.ResponseMetadata.collect do |response_metadata|
                  ResponseMetadata.domain_to_mapper(response_metadata)
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