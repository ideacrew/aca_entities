# frozen_string_literal: true

module AcaEntities
  module Accounts
    # Individual person or system account holder's preference settings
    class Profile < Dry::Struct
      # @!attribute [r] preferred_name
      # The account_holder's informal name
      # @return [String]
      attribute :preferred_name, Types::String.meta(omittable: false)

      # @!attribute [r] locale
      # Preferred system-supported language in ISO 639 encoding
      # @return [String]
      attribute :locale, AcaEntities::Types::LocaleKinds.meta(omittable: false)

      # @!attribute [r] notice_delivery_method
      # Preferred communication channel to receive system notices
      # @return [AcaEntities::Types::CommunicationKinds]
      attribute :notice_delivery_method, AcaEntities::Types::CommunicationKinds.meta(omittable: false)

      # @!attribute [r] electronic_communication_method
      # Preferred communication channel from system-supported electronic communication methods
      # @return [AcaEntities::Types::ElectronicCommunicationKinds]
      attribute :electronic_communication_method,
                AcaEntities::Types::ElectronicCommunicationKinds.meta(omittable: false)

      # @!attribute [r] email
      # Local Preferred email address for the account_holder to receive electronic communications
      # @return [String]
      attribute? :email, AcaEntities::Types::EmailOrNil.meta(omittable: true)

      # @!attribute [r] mobile_phone
      # Preferred mobile phone number for the account_holder to receive electronic communications
      # @return [String]
      attribute? :mobile_phone, AcaEntities::Types::NumbersOrNil.meta(omittable: true)

      # @!attribute [r] created_at
      # Timestamp when this record was originaly created in the data store
      # @return [Time]
      attribute? :created_at, AcaEntities::Types::TimeOrNil.meta(ommittable: true)

      # @!attribute [r] updated_at
      # Timestamp when this record was last changed in the data store
      # @return [Time]
      attribute? :updated_at, AcaEntities::Types::TimeOrNil.meta(ommittable: true)

      # Returns the upper case first letter of each space-separated string in #preferred_name
      def initials
        preferred_name.split.map { |n| n[0] }.join.upcase
      end
    end
  end
end
