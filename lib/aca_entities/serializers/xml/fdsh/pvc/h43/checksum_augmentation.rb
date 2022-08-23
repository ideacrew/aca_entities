# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module H43
            # Happymapper implementation for the root object of an DocumentBinary.
            class ChecksumAugmentation
              include HappyMapper
              register_namespace 'ext', 'http://rrvhtorresp.dsh.cms.gov/extension/1.0'
              register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

              tag 'ChecksumAugmentation'
              namespace 'hix-core'

              element :SHA256HashValueText, String, tag: 'SHA256HashValueText', namespace: 'ext'

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.SHA256HashValueText = request.SHA256HashValueText if request.SHA256HashValueText

                mapper
              end
            end
          end
        end
      end
    end
  end
end