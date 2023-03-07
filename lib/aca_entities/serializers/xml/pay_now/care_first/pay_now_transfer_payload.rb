# frozen_string_literal: true

module AcaEntities
    module Serializers
      module Xml
        module PayNow
          module CareFirst
            # Happymapper implementation for the root object of a PaynowTransferPayloadType.
            class PaynowTransferPayload
              include HappyMapper
  
              tag 'saml:AttributeValue'
              register_namespace 'xmlns', 'http://openhbx.org/api/terms/1.0'
              register_namespace 'cv', 'http://openhbx.org/api/terms/1.0'
              register_namespace 'xsi', 'http://www.w3.org/2001/XMLSchema-instance'
              register_namespace 'type', 'cv:PaynowTransferPayloadType'

              has_one :coverage_kind, CoverageKind
  
              def self.domain_to_mapper(pay_now_transfer_payload)
                mapper = self.new
                mapper.coverage_kin = CoverageKind.domain_to_mapper(pay_now_transfer_payload.coverage_kind)
                mapper
              end
  
            #   def to_hash
            #     {
            #       non_esi_mec_individual_information: transfer_header.to_hash
            #     }
            #   end
            end
          end
        end
      end
    end
  end