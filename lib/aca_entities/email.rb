# frozen_string_literal: true

module AcaEntities
  class Email < Dry::Struct

    attribute :kind, Types::String.optional
    attribute :address, Types::String.optional
  end
end
