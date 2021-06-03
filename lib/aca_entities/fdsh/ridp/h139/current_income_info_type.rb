# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for CurrentIncomeInfoType
        class CurrentIncomeInfoType < Dry::Struct

          attribute :response_metadata,               Fdsh::Ridp::H139::VerificationMetadataType.meta(omittable: false)
          attribute :employee_information,            Fdsh::Ridp::H139::PersonType.optional.meta(omittable: false)
          attribute :current_income_information,      Types::Array.of(Fdsh::Ridp::H139::CurrentHouseholdIncomeType).optional.meta(omittable: false)
        end
      end
    end
  end
end