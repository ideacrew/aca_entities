# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # Entity for RequestResult
    class RequestResult < Dry::Struct

      attribute :result, Types::String.optional.meta(omittable: true)
      attribute :source, Types::String.optional.meta(omittable: true)
      attribute :source_transaction_id, Types::String.optional.meta(omittable: true)
      attribute :code, Types::String.optional.meta(omittable: true)
      attribute :code_description, Types::String.optional.meta(omittable: true)
      attribute :raw_payload, Types::String.optional.meta(omittable: true)

    end
  end
end
