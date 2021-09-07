# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Api
          module Fti
            # A Response received from IRS
            class IRSResponse < Dry::Struct
              # @!attribute [r] RequestID
              # An HBX-assigned  numeric ID that uniquely identifies the request
              #   within a given message (both requests and responses)
              #   1-9 characters - numeric only
              # @return [AcaEntities::Fdsh::Ifsv::H9t::Types::RequestIDType]
              attribute :RequestID, AcaEntities::Types::String.meta(omittable: false)

              # @!attribute [r] Household
              # The group of information related to a IFSV applicant
              # @return [String]
              attribute :Household,
                        AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::Household.optional.meta(
                          omittable: true
                        )
            end
          end
        end
      end
    end
  end
end
