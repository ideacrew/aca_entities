# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for PersonEmploymentAssociationType
        class PersonEmploymentAssociationTypeContract < Dry::Validation::Contract
          params do
            optional(:employment_original_hire_date).maybe(:date)
          end
        end
      end
    end
  end
end