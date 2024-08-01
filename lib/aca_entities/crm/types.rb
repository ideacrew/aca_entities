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
      # A string representation of a Social Security Number in plain numbers format
      # @example
      #   "123456789"
      SSN = Types::String.constrained(format: /\A\d{9}\z/)

      # @!attribute [r] Phone
      # A string representation of a phone number in the format (XXX) XXX-XXXX
      # @example
      #   "(123) 456-7890"
      Phone = Types::String.constrained(format: /\A\(\d{3}\) \d{3}-\d{4}\z/)

      ACA_TO_SUGAR_RELATIONSHIP_MAPPING = {
        'self' => 'Self',
        'spouse' => 'Spouse',
        'domestic_partner' => 'Domestic Partner',
        'child' => 'Child',
        'parent' => 'Parent',
        'sibling' => 'Sibling',
        'unrelated' => 'Unrelated',
        'aunt_or_uncle' => 'Aunt or Uncle',
        'nephew_or_niece' => 'Nephew or Niece',
        'grandchild' => 'Grandchild',
        'grandparent' => 'Grandparent',
        'father_or_mother_in_law' => 'Father or Mother in Law',
        'daughter_or_son_in_law' => 'Daughter or Son in Law',
        'brother_or_sister_in_law' => 'Brother or Sister in Law',
        'cousin' => 'Cousin',
        'domestic_partners_child' => 'Domestic Partners Child',
        'parents_domestic_partner' => 'Parents Domestic Partner',
      }
    end
  end
end
