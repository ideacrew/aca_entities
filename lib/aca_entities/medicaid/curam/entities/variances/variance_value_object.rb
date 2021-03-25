# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Variances
        # Variance Value Object
        class VarianceValueObject < Sequent::ValueObject
          attrs aggregate_id: String, transaction_record_id: String, title: String, description: String,
                severity: String, assigned_to: String, status: String, status_result: String,
                updated_by: String, review_status: String, comments: array(::Curam::Comments::CommentValueObject)

          def self.from_params(params)
            comments = (params[:comments] || []).collect do |comment_attrs|
              comment_attrs.merge!(aggregate_id: Sequent.new_uuid) if comment_attrs[:aggregate_id].blank?
              ::Curam::Comments::CommentValueObject.new(comment_attrs)
            end
            self.new(params.merge(comments: comments))
          end
        end
      end
    end
  end
end
