# frozen_string_literal: true

module Ehs
  class Verifications::Residency < Dry::Struct

    attribute :residency_status,  Types::ResidencyStatusKind.meta(omittable: false)
  end
end
