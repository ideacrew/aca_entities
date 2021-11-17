# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp Organization augmentation
      class OrganizationAugmentation < Dry::Struct

        attribute :tin_identification, TinIdentification.optional.meta(omittable: true)
      end
    end
  end
end