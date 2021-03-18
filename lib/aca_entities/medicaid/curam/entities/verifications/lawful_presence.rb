# frozen_string_literal: true

module Ehs
  class Verifications::LawfulPresence < Dry::Struct

    attribute :is_lawfully_present, Types::Bool.meta(omittable: false)
    attribute :citizen_status,      Types::CitizenStatusKind.meta(omittable: false)
  end
end
