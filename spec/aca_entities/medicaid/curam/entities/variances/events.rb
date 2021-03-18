module Ehs
  module Variances
    module Events
      class VarianceCreated < Sequent::Event
        attrs aggregate_id: String, transaction_record_id: String, variance: Ehs::Variances::VarianceValueObject
      end

      class VarianceUpdated < Sequent::Event
        attrs aggregate_id: String, variance: Ehs::Variances::VarianceValueObject
      end

      class VarianceClosed < Sequent::Event
        attrs aggregate_id: String, updated_by: String, status: String
      end
    end
  end
end


