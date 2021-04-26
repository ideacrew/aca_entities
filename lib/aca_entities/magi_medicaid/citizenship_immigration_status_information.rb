# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for CitizenshipImmigrationStatusInformation.
    class CitizenshipImmigrationStatusInformation < Dry::Struct

      attribute :citizen_status, Types::CitizenKinds.meta(omittable: false)
      attribute :is_resident_post_092296, Types::Bool.optional.meta(omittable: true)
    end
  end
end
