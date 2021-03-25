# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Variances
        module Commands
          # Create Variance command
          class CreateVariance < Sequent::Command
            attrs variance: Curam::Variances::VarianceValueObject
          end

          # Update command variance
          class UpdateVariance < Sequent::Command
            attrs variance: Curam::Variances::VarianceValueObject
          end

          # close command variance
          class CloseVariance < Sequent::Command
            attrs updated_by: String
          end
        end
      end
    end
  end
end
