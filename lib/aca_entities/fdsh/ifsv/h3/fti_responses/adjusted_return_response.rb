# frozen_string_literal: true

module Fdsh
  module Irs
    module Responses
      class FtiResponse < Dry::Struct
        # attribute :ResponseMetadata
        # attribute :Household, Fdsh::Irs::Household
        # # A data type for metadata about a response
        # attribute :ResponseMetadata
        # # XPath of the specific element/attribute within the XML request/response data
        # attribute :XPathContent
        # attribute :Response do
        #   attribute :ResponseDescriptionText,
        #             Types::Coercible::String.meta(omittable: false)
        #   # A description of a response from a data source designated as trusted (a trusted data
        #   #   source or TDS) by the Centers for Medicare &amp; Medicaid Services. [CDM]
        #   attribute :TDSResponseDescriptionText,
        #             Types::Coercible::String.optional.meta(omittable: false)
        #   # An identifier for a request
        #   attribute :RequestID
        # end
        # # A Metadata about a response
        # attribute :ResponseMetadata do
        #   # A coded response
        #   attribute :ResponseCode,
        #             Types::Coercible::String.optional.meta(omittable: false)
        #   # A description of a response from a data source designated as trusted (a trusted data
        #   #   source or TDS) by the Centers for Medicare &amp; Medicaid Services. [CDM]
        #   attribute :TDSResponseDescriptionText,
        #             Types::Coercible::String.optional.meta(omittable: false)
        # end
        # attribute :tax_return, Fdsh::Irs::TaxReturn do
        #   attribute :tax_filer_tin
        #   attribute :spouse_tin
        #   attribute :income_amount, Types::Fdsh::Irs::Money
        # end
        # attribute :messages,
        #           Types::Array.of(Fdsh::Irs::Message).meta(omittable: false) do
        #   attribute :response_code, Type::String.meta(omittable: false)
        #   attribute :response_description_text,
        #             Type::String.meta(omittable: false)
        #   attribute :tds_response_description_text,
        #             Type::String.meta(omittable: false)
        # end
        # # A data type for Group of error messages
        # attribute :ErrorMessageSet do
        #   #  error message detail
        #   attribute :ErrorMessageDetail
        # end
      end
    end
  end
end
