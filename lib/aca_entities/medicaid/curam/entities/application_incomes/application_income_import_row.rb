# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ApplicationIncomes
        # entity for ApplicationIncomeImportRow
        class ApplicationIncomeImportRow < Dry::Struct
          attribute :category, Types::String.meta(omittable: false)
          attribute :status, Types::String.meta(omittable: false)
          attribute :case_id, Types::String.meta(omittable: false)
          attribute :case_reference, Types::String.meta(omittable: false)
          attribute :case_kind, Types::String.meta(omittable: false)
          attribute :evidence_descriptor_id, Types::String.meta(omittable: false)
          attribute :application_id, Types::String.meta(omittable: false)
          attribute :program_kind, Types::String.meta(omittable: false)
          attribute :frequency, Types::String.meta(omittable: false)
          attribute :start_date, Types::Date.meta(omittable: false)
          attribute :end_date, Types::Date.meta(omittable: true)
          attribute :kind, Types::String.meta(omittable: false)
          attribute :version, Types::String.meta(omittable: false)
          attribute :last_payment_date, Types::Date.meta(omittable: true)
          attribute :amount, Types::Decimal.meta(omittable: false)
          attribute :deduction_amount, Types::Decimal.meta(omittable: true)
          attribute :created_on, Types::DateTime.meta(omittable: false)
          attribute :last_update_on, Types::DateTime.meta(omittable: true)
        end
      end
    end
  end
end