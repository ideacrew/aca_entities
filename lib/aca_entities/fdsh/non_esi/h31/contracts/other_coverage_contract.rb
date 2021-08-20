# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH OtherCoverageContract
        class OtherCoverageContract < Dry::Validation::Contract
          params do
            required(:OrganizationCode).filled(AcaEntities::Fdsh::Types::TDSOrganizationCode)
            required(:ResponseMetadata).filled(AcaEntities::Fdsh::NonEsi::H31::ResponseMetaDataContract.params)
            optional(:MECCoverage).maybe(AcaEntities::Fdsh::NonEsi::H31::MECCoverageContract.params)
          end
        end
      end
    end
  end
end