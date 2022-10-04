# frozen_string_literal: true

module AcaEntities
  module People
    # Domain representation of an individual
    class Person < Dry::Struct
      attribute :external_person_link, Types::String.optional.meta(omittable: true)
      attribute :person_id, Types::String.optional.meta(omittable: true)
      attribute :hbx_id, Types::String.optional.meta(omittable: false)
      attribute :person_name, AcaEntities::People::PersonName.meta(omittable: false)
      attribute :person_demographics, AcaEntities::People::PersonDemographics.meta(omittable: false)
      attribute :person_health, AcaEntities::People::PersonHealth.meta(omittable: false)
      attribute :no_dc_address, Types::Bool.optional.meta(omittable: true)
      attribute :no_dc_address_reason, Types::String.optional.meta(omittable: true)
      attribute :is_homeless, Types::Bool.optional.meta(omittable: true)
      attribute :is_temporarily_out_of_state, Types::Bool.optional.meta(omittable: true)
      attribute :age_off_excluded, Types::Bool.optional.meta(omittable: true)
      attribute :is_applying_for_assistance, Types::Bool.optional.meta(omittable: true)
      attribute :is_active, Types::Bool.optional.meta(omittable: true)
      attribute :is_disabled, Types::Bool.optional.meta(omittable: true)
      attribute :person_relationships,
                Types::Array.of(AcaEntities::People::PersonRelationship).optional.meta(omittable: true)

      # attribute :roles, AcaEntities::Roles::Role.optional.meta(omittable: true)

      ### Deprecate individual attributes for each role type
      attribute :consumer_role, AcaEntities::People::ConsumerRole.optional.meta(omittable: true)
      attribute :resident_role, AcaEntities::People::ResidentRole.optional.meta(omittable: true)
      attribute :individual_market_transitions,
                Types::Array.of(AcaEntities::Determinations::IndividualMarketTransition).optional.meta(omittable: true)
      attribute :verification_types,
                Types::Array.of(AcaEntities::Verifications::VerificationType).optional.meta(omittable: true)
      attribute :broker_role, Brokers::BrokerRole.optional.meta(omittable: true)

      # @!attribute [r] user
      # @deprecated Use {omniauth_identity} instead
      # @return [AcaEntities::Accounts::User]
      attribute :user, AcaEntities::Accounts::User.meta(omittable: true)

      # @!attribute [r] account
      # @deprecated Use {omniauth_identity} instead
      # @return [AcaEntities::Accounts::Account]
      attribute :account, AcaEntities::Accounts::Account.meta(omittable: true)

      # @!attribute [r] user
      # Identity Management instance with this individual's credentials and client system access permissions
      # @return [AcaEntities::Identities::OmniauthIdentity]
      attribute :omniauth_identity, AcaEntities::Identities::OmniauthIdentity.meta(omittable: true)

      # attribute :broker_agency_staff_roles,              Types::Array.of(Brokers::BrokerAgencyStaffRole).optional.meta(omittable: true)
      # attribute :general_agency_staff_roles,             Types::Array.of(GeneralAgencies::GeneralAgencyStaffRole).optional.meta(omittable: true)
      # attribute :employee_roles,                         Types::Array.of(AcaEntities::People::EmployeeRole).optional.meta(omittable: true)
      # attribute :employer_staff_roles,                   Types::Array.of(AcaEntities::People::EmployerStaffRoles).optional.meta(omittable: true)
      attribute :addresses, Types::Array.of(AcaEntities::Locations::Address).optional.meta(omittable: true)
      attribute :emails, Types::Array.of(AcaEntities::Contacts::EmailContact).optional.meta(omittable: true)
      attribute :phones, Types::Array.of(AcaEntities::Contacts::PhoneContact).optional.meta(omittable: true)
      attribute :documents, Types::Array.of(AcaEntities::Documents::Document).optional.meta(omittable: true)

      attribute :timestamp, AcaEntities::TimeStamp.meta(omittable: true)

      def home_address
        return nil if addresses.empty?

        addresses.detect { |addr| addr.kind == 'home' }
      end

      def home_phone
        return nil if phones.empty?

        phones.detect { |phone| phone.kind == 'home' }
      end
    end
  end
end
