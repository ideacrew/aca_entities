# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        # A data concept for a Response information from IRS
        class IfsvResponse < Dry::Struct
          # @!attribute [r] RequestID
          # An HBX-assigned  numeric ID that uniquely identifies the request
          # within a given message (both requests and responses)
          # 1-9 characters - numeric only
          # @return [String]
          attribute :RequestID,
                    AcaEntities::Fdsh::Ifsv::H3::Types::RequestIDType.meta(
                      omittable: false
                    )

          # @!attribute [r] Household
          # An HBX-assigned  numeric ID that uniquely identifies the request
          # within a given message (both requests and responses)
          # 1-9 characters - numeric only
          # @return [String]
          attribute :Household,
                    AcaEntities::Fdsh::Ifsv::H3::FtiHousehold.meta(
                      omittable: true
                    )

          attribute :ErrorMesssage do
            attribute :ErrorMessageDetail do
              attribute :FtiResponseMetadata,
                        AcaEntities::Fdsh::Ifsv::H3::FtiResponseMetadata.meta(
                          omittable: false
                        )
            end
          end
        end
      end
    end
  end
end
