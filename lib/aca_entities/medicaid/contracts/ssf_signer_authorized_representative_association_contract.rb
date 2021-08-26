# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # SSF Signer Authorized Representative Association information contract
      class SsfSignerAuthorizedRepresentativeAssociationContract < Dry::Validation::Contract
        params do
          required(:signature).filled(:hash)
          optional(:authorized_representative_reference).maybe(:hash)
        end
      end
    end
  end
end