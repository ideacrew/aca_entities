# frozen_string_literal: true

module AcaEntities
  # Contains classes and modules related to CRM entities.
  module Crm
    # Represents a Contact entity with attributes validated by ContactContract
    class Contact < Dry::Struct
      # @!attribute [r] hbxid_c
      #   @return [String] unique identifier for the contact
      attribute :hbxid_c, Types::String.meta(omittable: false)

      # @!attribute [r] first_name
      #   @return [String] first name of the contact
      attribute :first_name, Types::String.meta(omittable: false)

      # @!attribute [r] last_name
      #   @return [String] last name of the contact
      attribute :last_name, Types::String.meta(omittable: false)

      # @!attribute [r] phone_mobile
      #   @return [String] mobile phone number
      attribute :phone_mobile, AcaEntities::Crm::Types::Phone.optional.meta(omittable: true)

      # @!attribute [r] email
      #   @return [String] email address
      attribute :email1, AcaEntities::Crm::Types::Email.optional.meta(omittable: true)

      # @!attribute [r] birthdate
      #   @return [Date] birth date
      attribute :birthdate, AcaEntities::Crm::Types::Dob.meta(omittable: false)

      # @!attribute [r] relationship_c
      #   @return [String] relationship to the account holder
      attribute :relationship_c, Types::String.meta(omittable: false)

      # Determines if another contact is the same as the current contact based on specific attributes.
      #
      # @param other_contact [Contact] The other contact to compare with.
      # @return [Boolean] Returns true if the other contact is the same as the current contact; false otherwise.
      def contact_same_as?(other_contact)
        return false unless other_contact.is_a?(Contact)

        (self <=> other_contact) == 0
      end

      # Compares the current contact with another contact based on a set of attributes.
      # The comparison is made in the order of hbxid_c, first_name, last_name, phone_mobile, email1, birthdate, and relationship_c.
      #
      # @param other [Contact] The other contact to compare with.
      # @return [Integer] Returns -1, 0, or 1 depending on whether the current contact is less than,
      #   equal to, or greater than the other contact, respectively.
      def <=>(other)
        [
          hbxid_c,
          first_name,
          last_name,
          phone_mobile,
          email1,
          birthdate,
          relationship_c
        ] <=> [
          other.hbxid_c,
          other.first_name,
          other.last_name,
          other.phone_mobile,
          other.email1,
          other.birthdate,
          other.relationship_c
        ]
      end
    end
  end
end
