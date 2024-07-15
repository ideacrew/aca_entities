# frozen_string_literal: true

module AcaEntities
  module Crm
    # Represents a Contact entity with attributes validated by ContactContract
    #
    # @!attribute [r] hbxid_c
    #   @return [String] unique identifier for the contact
    # @!attribute [r] first_name
    #   @return [String] first name of the contact
    # @!attribute [r] last_name
    #   @return [String] last name of the contact
    # @!attribute [r] phone_mobile
    #   @return [String] mobile phone number
    # @!attribute [r] email
    #   @return [String] email address
    # @!attribute [r] birthdate
    #   @return [Date] birth date
    # @!attribute [r] relationship_c
    #   @return [String] relationship to the account holder
    class Contact < Dry::Struct
      attribute :hbxid_c, Types::String.meta(omittable: false)
      attribute :first_name, Types::String.meta(omittable: false)
      attribute :last_name, Types::String.meta(omittable: false)
      attribute :phone_mobile, AcaEntities::Crm::Types::Phone.optional.meta(omittable: true)
      attribute :email1, AcaEntities::Crm::Types::Email.optional.meta(omittable: true)
      attribute :birthdate, AcaEntities::Crm::Types::Dob.meta(omittable: false)
      attribute :relationship_c, Types::String.meta(omittable: false)

      def contact_same_as?(other_contact)
        return false unless other_contact.is_a?(Contact)

        (self <=> other_contact) == 0
      end

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
