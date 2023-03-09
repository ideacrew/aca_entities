# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an ChecksumAugmentation.
          class ChecksumAugmentation
            include HappyMapper
            register_namespace 'ns3', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'ns4', "http://birsrep.dsh.cms.gov/extension/1.0"

            tag 'ChecksumAugmentation'
            namespace 'ns3'

            element :SHA256HashValueText, String, tag: 'SHA256HashValueText', namespace: 'ns4'

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