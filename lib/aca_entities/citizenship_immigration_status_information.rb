# frozen_string_literal: true

module AcaEntities
  class CitizenshipImmigrationStatusInformation < Dry::Struct

    attribute :us_citizen, Types::Bool
    attribute :naturalized_citizen, Types::Bool.optional.meta(omittable: true)
    attribute :sevis_id, Types::String.optional.meta(omittable: true)
    # Indicates if the citizenship/immigration document contains the same name as the applicant.
    attribute :same_name, Types::Bool.optional.meta(omittable: true)
    attribute :eligible_immigration_status, Types::Bool.optional.meta(omittable: true)
    # Indicates whether a person arrived in the US prior to 1996
    attribute :is_resident_pre_1996, Types::Bool.optional.meta(omittable: true)
  end
end
