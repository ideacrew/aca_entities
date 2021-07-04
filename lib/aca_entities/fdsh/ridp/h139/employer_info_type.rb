# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for EmployerInfoType
        class EmployerInfoType < Dry::Struct

          attribute :employerOrganization,     Fdsh::Ridp::H139::OrganizationType.meta(omittable: false)
          attribute :employerAddress,          Fdsh::Ridp::H139::StructuredAddressType.optional.meta(omittable: true)

        end
      end
    end
  end
end