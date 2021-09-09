# frozen_string_literal: true

module AcaEntities
  module Functions
    # build person email
    class BrokerAccountBuilder

      # TODO: applicationAssistors  # broker information
      # compare broker in application
      # "applicationAssistorType",
      # "creationDateTime",
      # "assistorFirstName",
      # "assistorLastName",
      # "assistorNationalProducerNumber",
      # "assistorMiddleName",
      # "assistorOrganizationId",
      # "assistorOrganizationName",
      # "assistorSystemUserName",
      # "assistorSuffix"

      # applicationAssistorType
      # NO_ASSISTANCE
      # AGENT_BROKER
      # CERTIFIED_APPLICATION_COUNSELOR
      # NAVIGATOR
      # IN_PERSON_ASSISTANT_PERSONNEL

      def call(cache)
        broker_accounts = cache.resolve('attestations.application').item[:applicationAssistors]
        return [] unless broker_accounts
        broker_accounts.each_with_object([]) do |account, collector|
          collector << broker_account_hash(account) if account[:applicationAssistorType] == "AGENT_BROKER"
          collector
        end
      end

      def broker_account_hash(account)
        { start_on: Date.new(2021, 11, 1),
          is_active: true,
          broker_role_reference: broker_role_reference_hash(account),
          broker_agency_reference: default_agency_hash }
      end

      def broker_role_reference_hash(account)
        {
          npn: account[:assistorNationalProducerNumber].to_s,
          person_reference: person_reference_hash(account),
          broker_agency_reference: default_agency_hash
        }
      end

      def person_reference_hash(account)
        {
          first_name: account[:assistorFirstName] || "default",
          middle_name: account[:assistorMiddleName] || "default",
          last_name: account[:assistorLastName] || "default",
          hbx_id: '1234',
          gender: "male"
        }
      end

      def default_agency_hash
        {
          hbx_id: "1234",
          market_kind: "individual",
          name: "default",
          fein: "123456789"
        }
      end
    end
  end
end

