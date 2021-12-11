# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # Entity for RequestResult
    class RequestResult < Dry::Struct

      attribute :source, Types::String.optional.meta(omittable: false)
      attribute :source_transaction_id, Types::String.optional.meta(omittable: true)
      attribute :error_code, Types::String.optional.meta(omittable: true)
      attribute :error_code_description, Types::String.optional.meta(omittable: true)
      attribute :raw_payload, Types::String.optional.meta(omittable: true)

    end
  end
end
