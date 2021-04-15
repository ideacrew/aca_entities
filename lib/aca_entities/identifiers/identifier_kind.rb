# frozen_string_literal: true

module AcaEntities
  module Identifiers

    IdentifierKinds = [].freeze

    # @example
    # {
    #   key_name:     :bt_temp_id,
    #   issuer:       { name: "Apple/Google group"},
    #   description:  'BlueTrace encounter messages patient Temporary ID',
    # }
    # {
    #   key_name:     :mobile_phone,
    #   description:  "Contact's mobile phone number in E.164 format"
    # }
    class IdentifierKind < Dry::Struct

      # @!attribute [r] key
      # Unique key for this identifier type
      # @return [Symbol]
      attribute :key,                     Types::IdentifierKindKey.meta(omittable: false)

      # @!attribute [r] label
      # Moniker for this identifer
      # @return [String]
      attribute :label,                   Types::String.meta(omittable: false)

      # @!attribute [r] label
      # Moniker for this identifer
      # @return [String]
      attribute :description,             Types::String.meta(omittable: true)

      # @!attribute [r] label
      # Moniker for this identifer
      # @return [String]
      attribute :namespace,               Types::IdentifierKindNamespace.meta(omittable: true)
    end
  end
end
