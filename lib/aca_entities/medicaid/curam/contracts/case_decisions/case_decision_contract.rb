# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module CaseDecisions
        # contract for CaseDecision
        class CaseDecisionContract < Curam::ApplicationContract
          config.messages.default_locale = :en

          params do
            required(:ids).array(:hash) do
              required(:key).filled(:string)
              required(:item).filled(:string)
              optional(:kind).maybe(:string)
              optional(:start_on).maybe(:date_time)
              optional(:end_on).maybe(:date_time)
            end
            required(:person).maybe(:hash)
            required(:amount).maybe(:decimal)
            required(:nominee_delivery_method).maybe(:string)
            required(:frequency).maybe(:string)
            required(:start_date).maybe(:date)
            required(:end_date).maybe(:date)
            required(:product_id).maybe(:string)
            required(:product_name).maybe(:string)
            required(:product_kind).maybe(:string)
            required(:determination_datetime).maybe(:date_time)
            required(:version_number).maybe(:string)
            required(:last_updated_at).maybe(:date_time)
          end

          rule(:person) do
            if key? && value
              result = Identifiers::IdReferenceContract.new.call(value)
              if result.success?
                values.merge!("#{key}": result.to_h)
              else
                key.failure(text: "invalid #{key}", error: result.errors.to_h)
              end
            end
          end
        end
      end
    end
  end
end