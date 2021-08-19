# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH VerifyNonEsiMECRequestContract
        class IndividualResponseContract < Dry::Validation::Contract
          params do
            required(:Applicant).filled(AcaEntities::Fdsh::NonEsi::H31::ApplicantContract.params)
            required(:PartialResponseIndicator).filled(:bool)
            required(:OtherCoverages).array(AcaEntities::Fdsh::NonEsi::H31::OtherCoverageContract.params)
          end
        end
      end
    end
  end
end