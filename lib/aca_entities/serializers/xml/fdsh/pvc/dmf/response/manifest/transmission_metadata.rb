# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Response
              module Manifest
                # Happymapper implementation for the root object of an TransmissionMetadata.
                class TransmissionMetadata
                  include HappyMapper
                  register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

                  tag 'TransmissionMetadata'
                  namespace 'hix-core'

                  element :TransmissionAttachmentQuantity, String, tag: 'TransmissionAttachmentQuantity', namespace: 'hix-core'
                  element :TransmissionSequenceID, String, tag: 'TransmissionSequenceID', namespace: 'hix-core'

                  def self.domain_to_mapper(request)
                    mapper = self.new
                    mapper.TransmissionAttachmentQuantity = request.TransmissionAttachmentQuantity
                    mapper.TransmissionSequenceID = request.TransmissionSequenceID

                    mapper
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end