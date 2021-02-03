# frozen_string_literal: true

module Iap
  class Employer < Dry::Struct

    attribute :employer_name,           Types::String.meta(omittable: false)
    attribute :employer_id,             Types::String.meta(omittable: false)

  end
end
