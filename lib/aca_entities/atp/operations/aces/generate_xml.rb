# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'aca_entities/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp/account_transfer_request'

module AcaEntities
  module Atp
    module Operations
      module Aces
        # Family Operations for atp payloads
        class GenerateXml
          include Dry::Monads[:result, :do, :try]

          def call(payload)
            valid_payload = yield validate(payload)
            aces_payload = yield aces_transform(valid_payload)
            _xml_payload = yield xml_transform(aces_payload)

            Success(true)
          end

          private

          def validate(params)
            Success(params)
          end

          def xml_transform(aces_payload)
            AcaEntities::Medicaid::Atp::AccountTransferRequest.new(aces_payload)
            AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.new(aces_payload)
          end

          def aces_transform(payload)
            record = JSON.parse(payload)
            family_members = record["family"]["family_members"]
            record["family"].merge!("family_members" => family_members.group_by do |h|
                                                          h["person"]["hbx_id"]
                                                        end.transform_keys(&:to_s).transform_values(&:first))
            applicants = record["family"]["magi_medicaid_applications"].first["applicants"]
            record["family"]["magi_medicaid_applications"].first.merge!("applicants" => applicants.group_by do |h|
                                                                                          h["person_hbx_id"]
                                                                                        end.transform_keys(&:to_s).transform_values(&:first))
            magi_medicaid_application = record["family"]["magi_medicaid_applications"].first
            record["family"].merge!("magi_medicaid_applications" => magi_medicaid_application)
            family_members = record["family"].delete("family_members")

            family_members.each do |family_member|
              person_relationships = family_member[1]["person"].delete("person_relationships")
              family_member[1]["person"].merge!("person_relationship" => person_relationships.first)

              person = family_member[1].delete("person")
              family_member[1].merge!("person" => person)
            end
            record["family"].merge!("family_members" => family_members)
            result = ::AcaEntities::Atp::Transformers::Aces::Family.transform(record)
            Success(result)
          end
        end
      end
    end
  end
end
