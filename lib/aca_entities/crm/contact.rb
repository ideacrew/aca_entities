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
      attribute :phone_mobile, AcaEntities::Crm::Types::Phone.meta(omittable: false)
      attribute :email, AcaEntities::Crm::Types::Email.meta(omittable: false)
      attribute :birthdate, AcaEntities::Crm::Types::Dob.meta(omittable: false)
      attribute :relationship_c, Types::String.meta(omittable: false)
    end
  end
end
