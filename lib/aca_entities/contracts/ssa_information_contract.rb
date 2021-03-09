# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for SsaInformation.
    class SsaInformationContract < Dry::Validation::Contract

      params do
        optional(:is_person_alive).maybe(:bool)
        optional(:is_person_incarcerated).maybe(:bool)
        optional(:prisoner_confinement_date).maybe(:date)
        optional(:prison_name).maybe(:string)
        optional(:prison_address).maybe(:string)
      end
    end
  end
end
