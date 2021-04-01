# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for CitizenshipImmigrationStatusInformation.
      class CitizenshipImmigrationStatusInformationContract < Dry::Validation::Contract
        params do
          optional(:citizen_status).maybe(Types::CitizenKinds)
          optional(:is_resident_post_092296).maybe(:bool)
        end
      end
    end
  end
end
