# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Employer
      class Employer < Dry::Struct
        attribute :id, Types::String.optional.meta(omittable: true)
        attribute :category_text, Types::String.optional.meta(omittable: true)
        attribute :organization_primary_contact_information, OrganizationPrimaryContactInformation.optional.meta(omittable: true)
      end
    end
  end
end