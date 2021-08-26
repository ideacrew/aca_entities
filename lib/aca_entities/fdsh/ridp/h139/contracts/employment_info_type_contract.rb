# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for EmploymentInfoType
        class EmploymentInfoTypeContract < Dry::Validation::Contract

          params do
            required(:employee_status_code).filled(:string)
            required(:employee_status_message).filled(:string)
            optional(:person_employment_association).maybe(Fdsh::Ridp::H139::PersonEmploymentAssociationTypeContract.params)
          end
        end
      end
    end
  end
end