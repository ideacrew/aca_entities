# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an ArrayOfSponsorshipData.
            class ArrayOfSponsorshipData
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'ArrayOfSponsorshipData'
              namespace 'vlp'

              has_many :SponsorshipData, SponsorshipData

              def self.domain_to_mapper(sponsorship_datas)
                mapper = self.new
                mapper.SponsorshipData = sponsorship_datas.collect do |sponsorship_data|
                  SponsorshipData.domain_to_mapper(sponsorship_data)
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