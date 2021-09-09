# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class IrsResponse
              include HappyMapper
              register_namespace 'ext', 'http://ifsv.dsh.cms.gov/extension/1.0'
              register_namespace 'hcore', 'http://hix.cms.gov/0.1/hix-core'

              tag 'IRSResponse'
              namespace 'ext'

              element :RequestID, String, tag: 'RequestID', namespace: "hcore"
              has_one :Household, Household

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.RequestID = response.RequestID
                mapper.Household = Household.domain_to_mapper(response.Household)
                mapper
              end
            end
          end
        end
      end
    end
  end
end