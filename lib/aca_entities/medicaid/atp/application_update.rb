# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp application update
      class ApplicationUpdate < Dry::Struct
        attribute :activity_id,      ActivityIdentification.optional.meta(omittable: true)
        attribute :activity_date,    ActivityDate.optional.meta(omittable: true)
      end
    end
  end
end