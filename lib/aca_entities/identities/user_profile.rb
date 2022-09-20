# frozen_string_literal: true

module AcaEntities
  module Identities
    # User preferences and configuration settings
    class UserProfile < Dry::Struct
      attribute :client_key, ::AcaEntities::Types::ClientKinds.meta(omittable: true)
      attribute :settings do
        attribute :locale, ::AcaEntities::Types::LocaleKinds.meta(omittable: true)
        attribute :communication_preference, ::AcaEntities::Types::CommunicationKinds.meta(omittable: true)
        attribute :electronic_communication_method,
                  ::AcaEntities::Types::ElectronicCommunicationKinds.meta(omittable: true)
      end
    end
  end
end
