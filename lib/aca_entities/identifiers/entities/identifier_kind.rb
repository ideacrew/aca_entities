# frozen_string_literal: true

module AcaEntities
  module Identifiers

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

      Kinds = [
        {
          key: :mobile_phone,
          label: "Mobile Phone",
          description: "Mobile phone number for party"
        },
        {
          key: :employee_id,
          label: "Employee ID",
          description: "Employer-assigned identifier for party"
        },
        {
          key: :patient_id,
          label: "Patient ID",
          description: "ID assigned by hospital, provider, lab or other heath care entity"
        },
        {
          key: :facebook_id,
          label: "Facebook ID",
          description: "Social media ID assigned by Facebook"
        },
        {
          key: :linkedin_id,
          label: "LinkedIn ID",
          description: "Social media ID assigned by LinkedIn"
        },
        {
          key: :twitter_id,
          label: "Twitter ID",
          description: "Social media ID assigned by Twitter"
        },
        {
          key: :instagram_id,
          label: "Instagram ID",
          description: "Social media ID assigned by Instagram"
        }
      ].freeze

      # @!attribute [r] key
      # Unique key for this identifier type
      # @return [Symbol]
      attribute :key,                     Types::Strict::Symbol.meta(omittable: false)

      # @!attribute [r] label
      # Moniker for this identifer
      # @return [String]
      attribute :label,                   Types::Strict::Symbol.meta(omittable: false)

      # @!attribute [r] source_key
      # Reference to the organization that issued the identifier
      # @return [CovidMost::IdentifierKind]
      attribute :issuer,                  Accounts::Account.optional.meta(omittable: true)

      attribute :description,             Types::Strict::String.meta(omittable: true)

    end
  end
end
