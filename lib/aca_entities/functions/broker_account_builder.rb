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
      BrokerNPNMapping = {"7383343"=>"10609371",
                          "17008816"=>"17008817",
                          "117367"=>"17311367",
                          "1735141"=>"17325141",
                          "260513"=>"17783181",
                          "3604039"=>"3684039",
                          "3685342"=>"3685342",
                          "711"=>"3688932",
                          "867302"=>"8673207",
                          "1795526"=>"17955267",
                          "36844183"=>"3684183",
                          "36812194"=>"3682194",
                          "1926613"=>"19263613",
                          "87818504"=>"8718504",
                          "4692969"=>"4632969",
                          "368188"=>"3681888",
                          "36801451"=>"3681451",
                          "8375570"=>"8375770",
                          "10564809"=>"10568409",
                          "9544749"=>"9544739",
                          "1111111"=>"3351659",
                          "3551659"=>"3351659",
                          "8591025"=>"8951425",
                          "1068793"=>"10687973",
                          "164112"=>"16411232",
                          "245892"=>"15953846",
                          "1877628"=>"18776268",
                          "2077979899"=>"7979899",
                          "231746"=>"2315746",
                          "155883573"=>"15883573",
                          "114661908"=>"14661908",
                          "33513117"=>"3351317",
                          "3371317"=>"3351317",
                          "2391255"=>"16440994"}

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
          npn: BrokerNPNMapping[account[:assistorNationalProducerNumber].to_s] || account[:assistorNationalProducerNumber].to_s,
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

