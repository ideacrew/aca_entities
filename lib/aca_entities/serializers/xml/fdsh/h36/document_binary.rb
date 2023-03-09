# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an DocumentBinary.
          class DocumentBinary
            include HappyMapper
            register_namespace 'ns3', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'ns5', "http://niem.gov/niem/niem-core/2.0"

            tag 'DocumentBinary'
            namespace 'ns5'

            has_one :ChecksumAugmentation, ChecksumAugmentation
            element :BinarySizeValue, Integer, tag: 'BinarySizeValue', namespace: 'ns3'

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