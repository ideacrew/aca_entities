# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp InitialVerificationRequestSet
        class InitialVerificationRequestSet < Dry::Struct

          attribute :DHSID,                                         Fdsh::Vlp::H92::DhsId.meta(omittable: false)
          attribute :FirstName,                                     Types::Strict::String.meta(omittable: false)
          attribute :MiddleName,                                    Types::String.optional.meta(omittable: true)
          attribute :LastName,                                      Types::Strict::String.meta(omittable: false)
          attribute :DateOfBirth,                                   Types::Strict::Date.meta(omittable: false)
          attribute :AKA,                                           Types::String.optional.meta(omittable: true)

          attribute :FiveYearBarApplicabilityIndicator,             Types::Bool.optional.meta(omittable: true)
          attribute :RequestSponsorDataIndicator,                   Types::Bool.optional.meta(omittable: true)
          attribute :RequestGrantDateIndicator,                     Types::Bool.optional.meta(omittable: true)
          attribute :SuspectedCounterfeitAlteredDocumentIndicator,  Types::Bool.optional.meta(omittable: true)
          attribute :RequestCubanHaitianEntrantIndicator,           Types::Bool.optional.meta(omittable: true)

          attribute :DocumentBinaryAttachment,                      Types::String.optional.meta(omittable: true)
          attribute :RequesterCommentsForHub,                       Types::String.optional.meta(omittable: true)

          attribute :CasePOCFullName,                               Types::String.optional.meta(omittable: true)
          attribute :CasePOCPhoneNumber,                            Types::String.optional.meta(omittable: true)
          attribute :CasePOCPhoneNumberExtension,                   Types::String.optional.meta(omittable: true)

        end
      end
    end
  end
end