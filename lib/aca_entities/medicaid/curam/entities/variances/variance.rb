# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Variances
        # entity for Variances
        class Variance < Dry::Struct
          attribute :id,                 Types::Integer.optional.meta(omittable: true)
          attribute :title,              Types::String.meta(omittable: false)
          attribute :description,        Types::String.optional.meta(omittable: true)
          attribute :status,             Types::String.meta(omittable: false)
          attribute :status_result,      Types::String.optional.meta(omittable: true)
          attribute :severity,           Types::String.meta(omittable: false)
          attribute :assigned_to,        Types::String.optional.meta(omittable: true)
          attribute :updated_by,         Types::String.optional.meta(omittable: true)
          attribute :review_status,      Types::String.optional.meta(omittable: true)
          attribute :created_at,         Types::DateTime.optional.meta(omittable: true)
          attribute :updated_at,         Types::DateTime.optional.meta(omittable: true)

          def failure?
            status == 'failure'
          end
        end
      end
    end
  end
end