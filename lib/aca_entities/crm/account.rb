# frozen_string_literal: true

module AcaEntities
  module Crm
    # Represents an Account entity with attributes validated by AccountContract
    #
    class Account < Dry::Struct
      # @!attribute [r] hbxid_c
      #   @return [String] unique identifier for the account
      attribute :hbxid_c, Types::String.meta(omittable: false)

      # @!attribute [r] name
      #   @return [String] name of the account
      attribute :name, Types::String.meta(omittable: false)

      # @!attribute [r] email1
      #   @return [String] primary email address
      attribute :email1, AcaEntities::Crm::Types::Email.meta(omittable: false)

      # @!attribute [r] billing_address_street
      #   @return [String] street address for billing
      attribute :billing_address_street, Types::String.meta(omittable: false)

      # @!attribute [r] billing_address_street2
      #   @return [String, nil] optional second street address for billing
      attribute :billing_address_street2, Types::String.optional.meta(omittable: true)

      # @!attribute [r] billing_address_street3
      #   @return [String, nil] optional third street address for billing
      attribute :billing_address_street3, Types::String.optional.meta(omittable: true)

      # @!attribute [r] billing_address_street4
      #   @return [String, nil] optional fourth street address for billing
      attribute :billing_address_street4, Types::String.optional.meta(omittable: true)

      # @!attribute [r] billing_address_city
      #   @return [String] city for billing address
      attribute :billing_address_city, Types::String.meta(omittable: false)

      # @!attribute [r] billing_address_postalcode
      #   @return [String] postal code for billing address
      attribute :billing_address_postalcode, Types::String.meta(omittable: false)

      # @!attribute [r] billing_address_state
      #   @return [String] state for billing address
      attribute :billing_address_state, Types::String.meta(omittable: false)

      # @!attribute [r] phone_office
      #   @return [String] office phone number
      attribute :phone_office, AcaEntities::Crm::Types::Phone.meta(omittable: false)

      # @!attribute [r] rawssn_c
      #   @return [String] Social Security Number
      attribute :rawssn_c, AcaEntities::Crm::Types::SSN.optional.meta(omittable: true)

      # @!attribute [r] raw_ssn_c
      #   @return [String] Social Security Number
      attribute :raw_ssn_c, AcaEntities::Crm::Types::SSN.meta(omittable: false)

      # @!attribute [r] dob_c
      #   @return [Date] date of birth
      attribute :dob_c, AcaEntities::Crm::Types::Dob.meta(omittable: false)

      # @!attribute [r] enroll_account_link_c
      #   @return [String, nil] optional link to enroll account
      attribute :enroll_account_link_c, Types::String.optional.meta(omittable: true)

      # @!attribute [r] contacts
      #   @return [Array<Contact>] array of associated contacts
      attribute :contacts, Types::Array.of(AcaEntities::Crm::Contact).meta(omittable: false)

      # Determines if another account is the same as the current account based on specific attributes.
      #
      # @param other_account [Account] The other account to compare with.
      # @return [Boolean] Returns true if the other account is the same as the current account; false otherwise.
      def account_same_as?(other_account)
        return false unless other_account.is_a?(Account)

        (self <=> other_account) == 0
      end

      # Compares the current account with another account based on a set of attributes.
      # The comparison is made in the order of hbxid_c, name, email1, billing_address_street, billing_address_street2,
      # billing_address_street3, billing_address_street4, billing_address_city, billing_address_postalcode,
      # billing_address_state, phone_office, rawssn_c, raw_ssn_c, dob_c, and enroll_account_link_c.
      #
      # @param other [Account] The other account to compare with.
      # @return [Integer] Returns -1, 0, or 1 depending on whether the current account is less than, equal to,
      #   or greater than the other account, respectively.
      def <=>(other)
        [
          hbxid_c, name, email1,
          billing_address_street,
          billing_address_street2,
          billing_address_street3,
          billing_address_street4,
          billing_address_city,
          billing_address_postalcode,
          billing_address_state,
          phone_office, rawssn_c,
          raw_ssn_c, dob_c,
          enroll_account_link_c
        ] <=> [
          other.hbxid_c, other.name, other.email1,
          other.billing_address_street,
          other.billing_address_street2,
          other.billing_address_street3,
          other.billing_address_street4,
          other.billing_address_city,
          other.billing_address_postalcode,
          other.billing_address_state,
          other.phone_office, other.rawssn_c,
          other.raw_ssn_c, other.dob_c,
          other.enroll_account_link_c
        ]
      end
    end
  end
end
