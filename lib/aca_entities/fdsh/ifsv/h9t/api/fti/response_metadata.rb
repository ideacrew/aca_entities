# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Api
          module Fti
            # A datatype for metadata about a response
            class ResponseMetadata < Dry::Struct
              # @!attribute [r] ResponseCode
              # IRS returns code(s) when a specific account condition exists and/or
              #   when certain information is not available for an individual
              # @return [String]
              attribute :ResponseCode, Types::String.optional.meta(omittable: true)

              # @!attribute [r] ResponseDescriptionText
              #  IRS returns description(s) to explain an account condition or to
              #   identify why certain information is not available for an individual
              # @return [String]
              attribute :ResponseDescriptionText,
                        Types::String.optional.meta(omittable: true)

              # @!attribute [r] TDSResponseDescriptionText
              # A description of a response from a data source designated as
              #   trusted (a trusted data source or TDS) by the Centers for
              #   Medicare &amp; Medicaid Services. [CDM]
              # @return [String]
              attribute :TDSResponseDescriptionText,
                        Types::String.optional.meta(omittable: true)
            end
          end
        end
      end
    end
  end
end
