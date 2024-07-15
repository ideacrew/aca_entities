# frozen_string_literal: true

module AcaEntities
  module Crm
    # Represents an Account entity with attributes validated by AccountContract
    #
    # @!attribute [r] hbxid_c
    #   @return [String] unique identifier for the account
    # @!attribute [r] name
    #   @return [String] name of the account
    # @!attribute [r] email1
    #   @return [String] primary email address
    # @!attribute [r] billing_address_street
    #   @return [String] street address for billing
    # @!attribute [r] billing_address_city
    #   @return [String] city for billing address
    # @!attribute [r] billing_address_postalcode
    #   @return [String] postal code for billing address
    # @!attribute [r] billing_address_state
    #   @return [String] state for billing address
    # @!attribute [r] phone_office
    #   @return [String] office phone number
    # @!attribute [r] raw_ssn_c
    #   @return [String] Social Security Number
    # @!attribute [r] dob_c
    #   @return [Date] date of birth
    # @!attribute [r] enroll_account_link_c
    #   @return [String, nil] optional link to enroll account
    # @!attribute [r] contacts
    #   @return [Array<Contact>] array of associated contacts
    class Account < Dry::Struct
      attribute :hbxid_c, Types::String.meta(omittable: false)
      attribute :name, Types::String.meta(omittable: false)
      attribute :email1, AcaEntities::Crm::Types::Email.meta(omittable: false)
      attribute :billing_address_street, Types::String.meta(omittable: false)
      attribute :billing_address_city, Types::String.meta(omittable: false)
      attribute :billing_address_postalcode, Types::String.meta(omittable: false)
      attribute :billing_address_state, Types::String.meta(omittable: false)
      attribute :phone_office, AcaEntities::Crm::Types::Phone.meta(omittable: false)
      attribute :raw_ssn_c, AcaEntities::Crm::Types::SSN.meta(omittable: false)
      attribute :dob_c, AcaEntities::Crm::Types::Dob.meta(omittable: false)
      attribute :enroll_account_link_c, Types::String.optional.meta(omittable: true)
      attribute :contacts, Types::Array.of(AcaEntities::Crm::Contact).meta(omittable: false)

      def account_same_as?(other_account)
        return false unless other_account.is_a?(Account)

        (self <=> other_account) == 0
      end

      def <=>(other)
        [
          hbxid_c,
          name,
          email1,
          billing_address_street,
          billing_address_city,
          billing_address_postalcode,
          billing_address_state,
          phone_office,
          raw_ssn_c,
          dob_c,
          enroll_account_link_c
        ] <=> [
          other.hbxid_c,
          other.name,
          other.email1,
          other.billing_address_street,
          other.billing_address_city,
          other.billing_address_postalcode,
          other.billing_address_state,
          other.phone_office,
          other.raw_ssn_c,
          other.dob_c,
          other.enroll_account_link_c
        ]
      end
    end
  end
end
