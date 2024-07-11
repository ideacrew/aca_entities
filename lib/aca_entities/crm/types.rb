# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Crm
    # A module for custom CRM(Customer Relationship Management) types
    module Types
      include Dry.Types
      include Dry::Logic

      # @!attribute [r] Dob
      # A string representation of a date of birth in the format YYYY-MM-DD
      # @example
      #   "1980-12-15"
      Dob = Types::String.constrained(format: /\A\d{4}-\d{2}-\d{2}\z/)

      # @!attribute [r] Email
      # A string representation of an email address
      # @example
      #   "example.user@example.com"
      Email = Types::String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)

      # @!attribute [r] SSN
      # A string representation of a Social Security Number in the format XXX-XX-XXXX
      # @example
      #   "123-45-6789"
      SSN = Types::String.constrained(format: /\A\d{3}-\d{2}-\d{4}\z/)

      # @!attribute [r] Phone
      # A string representation of a phone number in the format (XXX) XXX-XXXX
      # @example
      #   "(123) 456-7890"
      Phone = Types::String.constrained(format: /\A\(\d{3}\) \d{3}-\d{4}\z/)
    end
  end
end
