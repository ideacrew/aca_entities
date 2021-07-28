# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # Request.
            class InitialVerificationRequest
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'InitialVerificationRequest'
              namespace 'vlp'

              has_many :InitialVerificationRequestSets, InitialVerificationRequestSet

              def self.domain_to_mapper(initial_request)
                mapper = self.new
                mapper.InitialVerificationRequestSets = initial_request.InitialVerificationRequestSets.collect do |request_set|
                  InitialVerificationRequestSet.domain_to_mapper(request_set)
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
