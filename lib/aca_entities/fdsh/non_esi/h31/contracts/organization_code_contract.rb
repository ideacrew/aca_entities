# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH VerifyNonEsiMECRequestContract
        class OrganizationCodeContract < Dry::Validation::Contract
          params do
            required(:OrganizationCode).filled(AcaEntities::Fdsh::Types::TDSOrganizationCode)
          end
        end
      end
    end
  end
end