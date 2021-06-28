# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Happymapper implementation for the root object of an
          # AccountTransferRequest.
          class AccountTransferRequest
            include HappyMapper
            register_namespace 'ex', 'http://at.dsh.cms.gov/exchange/1.0'
            register_namespace 'ext', 'http://at.dsh.cms.gov/extension/1.0'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'niem-s', 'http://niem.gov/niem/structures/2.0'

            tag 'AccountTransferRequest'
            namespace 'ex'

            attribute :version, String, tag: "atVersionText", namespace: "ext"

            has_one :transfer_header, TransferHeader
            has_many :senders, Sender
            has_many :receivers, Receiver
            has_one :insurance_application, InsuranceApplication
            has_many :people, Person
            has_many :physical_households, PhysicalHousehold
            has_one :assister, Assister
            has_one :authorized_representative, AuthorizedRepresentative
            has_many :medicaid_households, MedicaidHousehold

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

            def to_hash(identifier: false)
              {
                version: "2.4",
                senders: [],
                receivers: [],
                transfer_header: transfer_header.to_hash,
                insurance_application: insurance_application.to_hash(identifier: true),
                record: identifier ? {people: people.map(&:to_hash).group_by{|h| h[:id]}.transform_keys(&:to_s).transform_values(&:first)} : nil,
                people: identifier ? nil : people.map(&:to_hash),
                physical_households: physical_households.map(&:to_hash)
              }
            end
          end
        end
      end
    end
  end
end