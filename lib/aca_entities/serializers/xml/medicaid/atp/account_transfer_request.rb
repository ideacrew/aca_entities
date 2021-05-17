# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class AccountTransferRequest
            include HappyMapper
            register_namespace 'ex', 'http://at.dsh.cms.gov/exchange/1.0'
            register_namespace 'ext', 'http://at.dsh.cms.gov/extension/1.0'

            tag 'AccountTransferRequest'
            namespace 'ex'

            attribute :version, String, tag: "atVersionText", namespace: "ext"

            has_one :transfer_header, TransferHeader
            has_many :senders, Sender
            has_many :receivers, Receiver
            has_one :insurance_application, InsuranceApplication
            has_many :people, Person
            has_many :physical_households, PhysicalHousehold

            def self.domain_to_mapper(account_transfer_request)
              mapper = self.new
              mapper.version = "2.4"
              mapper.senders = [Sender.domain_to_mapper(account_transfer_request.sender)]
              mapper.receivers = [Receiver.domain_to_mapper(account_transfer_request.receiver)]
              mapper.transfer_header = TransferHeader.domain_to_mapper(account_transfer_request.transfer_header)
              mapper.insurance_application = InsuranceApplication.domain_to_mapper(account_transfer_request.insurance_application)
              mapper.people = [Person.domain_to_mapper(account_transfer_request.person)]
              mapper.physical_households = [PhysicalHousehold.domain_to_mapper(account_transfer_request.physical_household)]
              mapper
            end
          end
        end
      end
    end
  end
end