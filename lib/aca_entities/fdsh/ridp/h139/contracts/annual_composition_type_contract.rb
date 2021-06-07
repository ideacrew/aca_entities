# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for AnnualCompensationType
        class AnnualCompensationTypeContract < Dry::Validation::Contract

          params do
            optional(:annual_compensation_information).array(Fdsh::Ridp::H139::AnnualCompensationInformationTypeContract.params)
          end

        end
      end
    end
  end
end