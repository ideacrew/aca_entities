# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module H43
            # Happymapper implementation for the root object of an DocumentBinary.
            class DocumentBinary
              include HappyMapper
              register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

              tag 'DocumentBinary'
              namespace 'hix-core'

              has_one :ChecksumAugmentation, ChecksumAugmentation
              element :BinarySizeValue, Integer, tag: 'BinarySizeValue', namespace: 'hix-core'

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.ChecksumAugmentation = ChecksumAugmentation.domain_to_mapper(request.ChecksumAugmentation) if request.ChecksumAugmentation
                mapper.BinarySizeValue = request.BinarySizeValue if request.BinarySizeValue

                mapper
              end
            end
          end
        end
      end
    end
  end
end