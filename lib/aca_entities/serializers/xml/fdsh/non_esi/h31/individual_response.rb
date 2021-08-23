# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an Individual response.
            class IndividualResponse
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'

              tag 'IndividualResponse'
              namespace 'vnem'

              has_one :Applicant, Applicant
              element :PartialResponseIndicator, Boolean, tag: 'PartialResponseIndicator', namespace: 'vnem'
              has_many :OtherCoverages, OtherCoverage

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.Applicant = Applicant.domain_to_mapper(response.Applicant)
                mapper.PartialResponseIndicator = response.PartialResponseIndicator
                mapper.OtherCoverages = response.OtherCoverages.collect do |other_coverage|
                  OtherCoverage.domain_to_mapper(other_coverage)
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
