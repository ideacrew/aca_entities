# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for AnnualCompensationInformationType
        class AnnualCompensationInformationTypeContract < Dry::Validation::Contract

          params do
            optional(:income_year).maybe(:date)
            optional(:base_compensation).maybe(:float)
            optional(:total_compensation).maybe(:float)
          end
        end
      end
    end
  end
end