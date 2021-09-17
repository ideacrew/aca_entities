# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Ifsv
            # Happymapper implementation for the root object of an Response.
            class ErrorMessageDetail
              include HappyMapper
              register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

              tag 'ErrorMessageDetail'
              namespace 'irs'

              element :ErrorMessageCd, String, tag: 'ErrorMessageCd', namespace: 'irs'
              element :ErrorMessageTxt, String, tag: 'ErrorMessageTxt', namespace: 'irs'
              element :XpathContent, String, tag: 'XpathContent', namespace: 'irs'


              def self.domain_to_mapper(error_message)
                mapper = self.new
                mapper.ErrorMessageCd = error_message.ErrorMessageCd
                mapper.ErrorMessageTxt = error_message.ErrorMessageTxt
                mapper.XpathContent = error_message.XpathContent

                mapper
              end
            end
          end
        end
      end
    end
  end
end
