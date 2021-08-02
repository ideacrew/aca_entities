# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp application creation
      class ApplicationCreation < Dry::Struct
        attribute :creation_id,      ActivityIdentification.optional.meta(omittable: true)
        attribute :creation_date,    ActivityDate.optional.meta(omittable: true)
      end
    end
  end
end