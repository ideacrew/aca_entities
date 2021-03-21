# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module CallCenter
    # callcenter types
    module Types
      send(:include, Dry.Types())
      send(:include, Dry::Logic)

      ContactFlow = Types::Coercible::String.default("CONTACT_FLOW").enum(
        "CONTACT_FLOW",
        "CUSTOMER_QUEUE",
        "CUSTOMER_HOLD",
        "CUSTOMER_WHISPER",
        "AGENT_HOLD",
        "AGENT_WHISPER",
        "OUTBOUND_WHISPER",
        "AGENT_TRANSFER",
        "QUEUE_TRANSFER"
      )

      Queue             = Types::Coercible::String.default("STANDARD").enum("STANDARD", "AGENT")

      Channel           = Types::Coercible::String.default("VOICE").enum("VOICE", "CHAT")
      Phone             = Types::Coercible::String.default("SOFT_PHONE").enum("SOFT_PHONE", "DESK_PHONE")

      # E.164 Standard
      PhoneNumber       = Types::String.constrained(format: /^\+(?:[0-9] ?){6,14}[0-9]$/)

      Email             = Types::String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      EmailOrString     = CallCenter::Types::Email | Types::String

      Environment       = Types::Coercible::Symbol.default(:production).enum(:development, :test, :production)
      Serializers       = Types::String.default('yaml_serializer').enum('yaml_serializer', 'xml_serializer')
      Stores            = Types::String.default('file_store').enum('file_store')

      CallableDate      = Types::Date.default { Date.today }
      CallableDateTime  = Types::DateTime.default { DateTime.now }

      RequiredSymbol    = Types::Strict::Symbol.constrained(min_size: 2)

      HashOrNil         = Types::Hash | Types::Nil
      StringOrNil       = Types::String | Types::Nil

      RequiredString    = Types::Strict::String.constrained(min_size: 1)
      StrippedString    = Types::String.constructor(&:strip)
      SymbolOrString    = Types::Symbol | Types::String
      NilOrString       = Types::Nil | Types::String

      StrictSymbolizingHash = Types::Hash.schema({}).strict.with_key_transform(&:to_sym)

      Callable = Types.Interface(:call)

    end
  end
end