# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for OrganizationType
        class OrganizationType < Dry::Struct

          attribute :organization_identification,      Types::String.meta(omittable: false)
          attribute :organization_name,                Types::String.meta(omittable: false)

        end
      end
    end
  end
end