# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an applicant response set.
            class ApplicantResponseSet
              include HappyMapper
              register_namespace 'ext', 'http://vesim.dsh.cms.gov/extension/1.0'

              tag 'ApplicantResponseSet'
              namespace 'ext'

              has_many :ApplicantResponses, ApplicantResponse

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.ApplicantResponses = response.ApplicantResponses.collect do |applicant_response|
                  ApplicantResponse.domain_to_mapper(applicant_response)
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
