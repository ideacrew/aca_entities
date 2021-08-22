# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH VerifyNonEsiMECRequestContract
        class OrganizationContract < Dry::Validation::Contract
          params do
            required(:OrganizationCodes).array(AcaEntities::Fdsh::Types::TDSOrganizationCode)
          end
        end
      end
    end
  end
end