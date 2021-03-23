# frozen_string_literal: true

module AcaEntities
  module Iap
    class Family < Dry::Struct

      attribute :applications, Types::Array.of(Iap::Application).meta(omittable: true)

    end
  end
end