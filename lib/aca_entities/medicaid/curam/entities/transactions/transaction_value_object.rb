# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Transactions
        # TransactionValueObject
        class TransactionValueObject < Sequent::ValueObject
          attrs(
            kind: String,
            message: String,
            operation_name: String,
            correlation_id: String,
            object_id: String,
            object_type: String,
            title: String,
            description: String,
            entity_name: String,
            event_name: String,
            reference_id: String,
            variances: array(::Curam::Variances::VarianceValueObject)
          )

          def self.from_params(params)
            variances = (params[:variances] || []).collect do |variance_attrs|
              variance_attrs.merge!(aggregate_id: Sequent.new_uuid) if variance_attrs[:aggregate_id].blank?
              ::Curam::Variances::VarianceValueObject.from_params(variance_attrs)
            end

            new(params.merge(variances: variances))
          end

          def self.from_entity(entity)
            from_params(entity.to_h)
          end
        end
      end
    end
  end
end
