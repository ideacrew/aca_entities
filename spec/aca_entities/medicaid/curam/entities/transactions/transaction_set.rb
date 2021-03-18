# frozen_string_literal: true

module Ehs
  class Transactions::TransactionSet < Dry::Struct

    attribute :ids,               Types::Array.of(Ehs::Identifiers::Id).optional.meta(omittable: true)
    attribute :kind,              Types::String.meta(omittable: false) # controller name
    attribute :header,            Types::String.meta(omittable: true)
    attribute :message,           Types::String.meta(omittable: false)
    attribute :transactions,      Types::Array.of(Ehs::Transactions::Transaction).meta(omittable: true)
    attribute :response_code,     Types::Integer.meta(omittable: false)
    attribute :response_message,  Types::String.meta(omittable: true)
    attribute :created_at,        Types::DateTime.meta(omittable: false)
    attribute :updated_at,        Types::DateTime.meta(omittable: false)
  end
end