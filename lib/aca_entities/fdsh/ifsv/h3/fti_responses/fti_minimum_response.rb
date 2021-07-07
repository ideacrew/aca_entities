# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        module FtiResponses
          # Response data elements for FDSH FTI MinimumResponse
          # @example XML format
          #  <ext:ErrorMessage>
          #       <ext:ErrorMessageDetail>
          #           <hcore:ResponseMetadata>
          #               <hcore:ResponseCode>ResponseCode0</hcore:ResponseCode>
          #               <hcore:ResponseDescriptionText>ResponseDescriptionText0</hcore:ResponseDescriptionText>
          #           </hcore:ResponseMetadata>
          #       </ext:ErrorMessageDetail>
          #   </ext:ErrorMessage>
          class MinimumResponse < Dry::Struct
            # IRS returns code(s) when a specific account condition exists and/or
            #   when certain information is not available for an individual
            attribute :ResponseCode, Types::String.meta(omittable: false)

            #  IRS returns description(s) to explain an account condition or to
            #   identify why certain information is not available for an individual
            attribute :ResponseDescriptionText,
                      Types::String.meta(omittable: false)

            attribute :TDSResponseDescriptionText,
                      Types::String.meta(omittable: true)
          end
        end
      end
    end
  end
end
