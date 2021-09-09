# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class SpouseTaxFiler
              include HappyMapper
              register_namespace 'hee', 'http://hix.cms.gov/0.1/hix-ee'
              register_namespace 'hcore', 'http://hix.cms.gov/0.1/hix-core'

              tag 'SpouseTaxFiler'
              namespace 'hee'

              element :TINIdentification, String, tag: 'TINIdentification', namespace: "hcore"

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.TINIdentification = response.TINIdentification

                mapper
              end
            end
          end
        end
      end
    end
  end
end