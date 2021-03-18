# frozen_string_literal: true

module Ehs
  module CaseDecisions
    class IntegratedCaseTransformContract < Ehs::ApplicationContract

      params do
        required(:source_system_key).maybe(:string)
        required(:ids).array(:hash) do
          required(:key).filled(:string)
          required(:item).filled(:string)
          optional(:kind).maybe(:string)
          optional(:start_on).maybe(:date_time)
          optional(:end_on).maybe(:date_time)
        end
        required(:applications).array(:hash)
      end

      rule(:applications) do
        if key? && value
          results = []
          value.each do |value_hash|
            result = ::Ehs::CaseDecisions::ApplicationTransformContract.new.call(value_hash)

            if result.success?
              results << result.to_h
            else
              key.failure(text: "invalid #{key}", error: result.errors.to_h)
            end
          end

          values.merge!("#{key}": results) if results.present?
        end
      end
    end
  end
end