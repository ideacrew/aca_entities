module Ehs
  module Variances
    module Commands

      class CreateVariance < Sequent::Command
        attrs variance: Ehs::Variances::VarianceValueObject
      end
      
      class UpdateVariance < Sequent::Command
        attrs variance: Ehs::Variances::VarianceValueObject
      end

      class CloseVariance < Sequent::Command
        attrs updated_by: String
      end
    end
  end
end
