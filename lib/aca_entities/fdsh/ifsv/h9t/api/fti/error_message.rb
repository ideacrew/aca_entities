# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Api
          module Fti
            # Response returned when an error occurs processing a request
            class ErrorMessage < Dry::Struct
              attribute :ErrorMessageDetail do
                # @!attribute [r] ResponseMetadata
                # A datatype for metadata about an error
                # @return [String]
                attribute :ResponseMetadata,
                          AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::ResponseMetadata
                            .optional.meta(omittable: true)

                # @!attribute [r] XPathContent
                # XPath of the specific element/attribute within the
                #   XML request/response data
                # @return [String]
                attribute :XPathContent,
                          AcaEntities::Types::String.optional.meta(omittable: true)
              end
            end
          end
        end
      end
    end
  end
end
