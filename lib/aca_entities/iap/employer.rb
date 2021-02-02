# frozen_string_literal: true

module AcaEntities
  module Iap
    class Employer

      attribute :employer_name,           Types::String.meta(omittable: false)
      attribute :employer_id,             Types::String.meta(omittable: false)

    end
  end
end
