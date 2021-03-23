# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Variances
        module Events
          # variance create event
          class VarianceCreated < Sequent::Event
            attrs aggregate_id: String, transaction_record_id: String, variance: Curam::Variances::VarianceValueObject
          end

          # variance update event
          class VarianceUpdated < Sequent::Event
            attrs aggregate_id: String, variance: Curam::Variances::VarianceValueObject
          end

          # variance closed event
          class VarianceClosed < Sequent::Event
            attrs aggregate_id: String, updated_by: String, status: String
          end
        end
      end
    end
  end
end


