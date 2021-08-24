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
            register_namespace 'xsi', 'http://www.w3.org/2001/XMLSchema-instance'            

            tag 'AccountTransferRequest'
            namespace 'ex'

            # Account Transfer Version Number
            attribute :version, String, tag: "atVersionText", namespace: "ext"

            # A entity that starts the referral process.
            has_one :transfer_header, TransferHeader

            # An information exchange system sending information.
            has_many :senders, Sender

            # An information exchange system receiving information.
            has_many :receivers, Receiver

            # A data type for a formal request to establish insurance coverage for the applicants named in the application.
            has_one :insurance_application, InsuranceApplication

            # A data type for a certified assister (such as a navigator) who helps individuals complete an insurance application.
            has_one :assister, Assister

            # A reference to a person designated as an authorized representative.
            has_one :authorized_representative, AuthorizedRepresentative

            # A collection of persons to be treated as a unit under Medicaid.
            has_many :medicaid_households, MedicaidHousehold

            # Acts as A human being.
            has_many :people, Person

            # A tax return as filed with the Internal Revenue Service.
            has_many :tax_returns, TaxReturn

            # A Metadata about any object, provided by a verifying authority.
            has_many :verification_metadata, VerificationMetadata

            # A set of persons that reside together.
            has_many :physical_households, PhysicalHousehold

            def self.domain_to_mapper(account_transfer_request)
              mapper = self.new
              mapper.version = "2.4"
              mapper.senders = account_transfer_request.senders.map {|s| Sender.domain_to_mapper(s)}
              mapper.receivers = account_transfer_request.receivers.map {|r| Receiver.domain_to_mapper(r)}
              mapper.transfer_header = TransferHeader.domain_to_mapper(account_transfer_request.transfer_header)
              mapper.insurance_application = InsuranceApplication.domain_to_mapper(account_transfer_request.insurance_application)
              mapper.people = account_transfer_request.people.map {|p| Person.domain_to_mapper(p)}
              mapper.physical_households = account_transfer_request.physical_households.map {|ph| PhysicalHousehold.domain_to_mapper(ph)}
              unless account_transfer_request.medicaid_households.nil?
                mapper.medicaid_households = account_transfer_request.medicaid_households.map {|vm| MedicaidHousehold.domain_to_mapper(vm)}
              end
              if account_transfer_request.verification_metadata
                mapper.verification_metadata = account_transfer_request.verification_metadata.map {|vm| VerificationMetadata.domain_to_mapper(vm)}
              end
              mapper.tax_returns = account_transfer_request.tax_returns&.map { |tr| TaxReturn.domain_to_mapper(tr) }
              mapper
            end

            def to_hash(identifier: false)
              {
                version: "2.4",
                senders: senders,
                receivers: receivers,
                transfer_header: transfer_header.to_hash,
                # insurance_application: insurance_application.to_hash(identifier: true).merge(tax_return: tax_return&.to_hash),
                insurance_application: insurance_application.to_hash(identifier: true).merge(tax_returns: tax_returns.map(&:to_hash).first),
                record: identifier ? { people: people.map(&:to_hash).group_by {|h| h[:id]}.transform_keys(&:to_s).transform_values(&:first) } : nil,
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