# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for CurrentHouseholdIncomeType
        class CurrentHouseholdIncomeType < Dry::Struct

          attribute :tier,                            Types::Integer.optional.meta(omittable: true)
          attribute :as_of_date,                      Types::Date.meta(omittable: false)
          attribute :verification_metadata,           Fdsh::Ridp::H139::VerificationMetadataType.meta(omittable: false)
          attribute :employee_information,            Fdsh::Ridp::H139::PersonType.meta(omittable: false)
          attribute :employer_information,            Fdsh::Ridp::H139::EmployerInfoType.meta(omittable: false)
          attribute :employment_info_type,            Fdsh::Ridp::H139::EmploymentInfoType.meta(omittable: false)
          attribute :base_compensation_information,   Fdsh::Ridp::H139::BaseCompensationInfoType.optional.meta(omittable: true)
          attribute :annual_compensation,             Fdsh::Ridp::H139::AnnualCompensationType.optional.meta(omittable: true)
          attribute :PayPeriod,                       Fdsh::Ridp::H139::PayPeriodInformationType.optional.meta(omittable: false)
        end
      end
    end
  end
end