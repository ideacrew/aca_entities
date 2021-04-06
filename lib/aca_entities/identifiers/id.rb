# frozen_string_literal: true

module AcaEntities
  module Identifiers
    # @example
    # { key: 'urn:openhbx:hbx:dc0:resources:v1:curam:concern_role', item: '8422201791080300544' }
    # { key: 'urn:openhbx:hbx:dc0:resources:v1:curam:integrated_case', item: '2740646' }
    class Id < Dry::Struct
      attribute :key,         Types::String.meta(omittable: false)
      attribute :item,        Types::String.meta(omittable: false)
      attribute :start_on,    Types::DateTime.optional.meta(omittable: true)
      attribute :end_on,      Types::DateTime.optional.meta(omittable: true)
      attribute :label,       Types::Symbol.optional.meta(omittable: true)
      attribute :description, Types::String.optional.meta(omittable: true)

      def to_uri
        "#{key}##{item}"
      end
    end
  end
end
