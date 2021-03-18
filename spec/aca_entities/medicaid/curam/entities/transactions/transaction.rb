# frozen_string_literal: true

module Ehs
  class Transactions::Transaction < Dry::Struct

    attribute :id,                Types::Integer.optional.meta(omittable: true)
    attribute :kind,              Types::String.meta(omittable: false)
    attribute :message,           Types::String.optional.meta(omittable: true)
    attribute :variances,         Types::Array.of(Variances::Variance).optional.meta(omittable: true)
    attribute :operation_name,    Types::String.meta(omittable: false)
    attribute :correlation_id,    Types::String.optional.meta(omittable: true)
    attribute :title,             Types::String.optional.meta(omittable: true)
    attribute :description,       Types::String.optional.meta(omittable: true)
    attribute :reference_id,      Types::String.optional.meta(omittable: true)
    attribute :object_id,         Types::String.optional.meta(omittable: true)
    attribute :object_type,       Types::String.optional.meta(omittable: true)
    attribute :variance_count,    Types::Integer.optional.meta(omittable: true)
    attribute :failed_variance_count, Types::Integer.optional.meta(omittable: true)
    attribute :entity_name,       Types::String.optional.meta(omittable: true)
    attribute :event_name,        Types::String.optional.meta(omittable: true)
    attribute :created_at,        Types::DateTime.optional.meta(omittable: true)
    attribute :updated_at,        Types::DateTime.optional.meta(omittable: true)

    def initialize(args)
      args.merge!(
        variance_count: variance_count(args[:variances]),
        failed_variance_count: failed_variance_count(args[:variances]),
        entity_name: entity_name_for(args[:variances]) #(args[:entity_name] || args[:operation_name].demodulize.titleize)
      )
      super(args)
    end

    def entity_name_for(values)
      key_mapping = {
        'Income Evidence Flagged as Non-countable' => 'Income Misallocation',
        'Social Security Income Evidence Flagged as Unearned Income' => 'Missing Income',
        'IncomeEvidence Update without Case Decision' => 'Payment Miscalculation'
      }
      variance = values.first
      key_mapping[variance[:title]]
    end

    def operation_result
      return unless primary_variance
      json_result = primary_variance.status_result

      JSON.parse(json_result)
    end

    def operation_success?
      return false unless operation_status
      operation_status == '200'
    end

    def primary_variance
      variances.first
    end

    def operation_status
      return if primary_variance.blank?

      primary_variance.status
    end

    def variance_count(records)
      records&.size
    end

    def failed_variance_count(records)
      records&.count(&:failure?)
    end
  end
end
