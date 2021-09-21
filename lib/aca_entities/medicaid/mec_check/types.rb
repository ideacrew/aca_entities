# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      # Shared type definitions for MEC Check
      module Types
        include Dry::Types()

        GenderCode = String.enum("M", "F")
        OrganizationCode = String.enum("MEDC", "CHIP")

      end

    end
  end
end