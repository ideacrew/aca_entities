# frozen_string_literal: true

module Ehs
  module Evidences
    class EvidenceTransformContract < Ehs::ApplicationContract

      params do
        optional(:source_system_key).maybe(:string)
        required(:ids).array(:hash) do
          required(:key).filled(:string)
          required(:item).filled(:string)
          optional(:kind).maybe(:string)
          optional(:start_on).maybe(:date_time)
          optional(:end_on).maybe(:date_time)
        end
        required(:evidence_status).filled(Ehs::Types::EvidenceStatusType)
        required(:version).filled(:integer)
        required(:created_at).filled(:date_time)
        required(:last_updated_at).filled(:date_time)
        optional(:integrated_case).maybe(:hash) do
          required(:source_system_key).filled(:string)
          required(:ids).array(:hash) do
            required(:key).filled(:string)
            required(:item).filled(:string)
            optional(:kind).maybe(:string)
            optional(:start_on).maybe(:date_time)
            optional(:end_on).maybe(:date_time)
          end
        end
        optional(:person).maybe(:hash) do
          required(:source_system_key).filled(:string)
          required(:ids).array(:hash) do
            required(:key).filled(:string)
            required(:item).filled(:string)
            optional(:kind).maybe(:string)
            optional(:start_on).maybe(:date_time)
            optional(:end_on).maybe(:date_time)
          end
        end
        optional(:incomes).array(:hash) do
          required(:source_system_key).filled(:string)
          required(:ids).array(:hash) do
            required(:key).filled(:string)
            required(:item).filled(:string)
            optional(:kind).maybe(:string)
            optional(:start_on).maybe(:date_time)
            optional(:end_on).maybe(:date_time)
          end
          required(:category).filled(:string)
          required(:kind).filled(:string)
          required(:frequency).filled(:string)
          required(:amount).filled(:decimal)
          required(:start_date).filled(:date)
          optional(:end_date).maybe(:date)
          optional(:last_payment_date).maybe(:date)
          optional(:deduction_amount).maybe(:decimal)
          optional(:deduction_kind).maybe(:string)
        end
      end
    end
  end
end
