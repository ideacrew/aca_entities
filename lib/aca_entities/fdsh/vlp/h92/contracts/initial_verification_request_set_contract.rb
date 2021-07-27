# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp InitialVerificationRequestSet
        class InitialVerificationRequestSetContract < Dry::Validation::Contract

          params do
            required(:DHSID).filled(Fdsh::Vlp::H92::DhsIdContract.params)
            required(:FirstName).filled(:string)
            optional(:MiddleName).maybe(:string)
            required(:LastName).filled(:string)
            required(:DateOfBirth).filled(:date)
            optional(:AKA).maybe(:string)

            optional(:FiveYearBarApplicabilityIndicator).maybe(:bool)
            optional(:RequestSponsorDataIndicator).maybe(:bool)
            optional(:RequestGrantDateIndicator).maybe(:bool)
            optional(:SuspectedCounterfeitAlteredDocumentIndicator).maybe(:bool)
            optional(:RequestCubanHaitianEntrantIndicator).maybe(:bool)

            optional(:DocumentBinaryAttachment).maybe(:string)
            optional(:RequesterCommentsForHub).maybe(:string)

            optional(:CasePOCFullName).maybe(:string)
            optional(:CasePOCPhoneNumber).maybe(:string)
            optional(:CasePOCPhoneNumberExtension).maybe(:string)

          end
        end
      end
    end
  end
end