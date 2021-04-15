# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module IntegratedCases
        # entity for IntegratedCase
        class IntegratedCase < Dry::Struct
          include ActiveModel::Conversion
          extend ActiveModel::Naming

          attribute :ids,                    Types::Array.of(Curam::Identifiers::Id).meta(omittable: false)
          attribute :case_reference,         Types::String.meta(omittable: true)
          attribute :evidences,              Types::Array.of(Evidences::Evidence).optional.meta(omittable: true)
          attribute :applications,           Types::Array.of(Applications::Application).meta(omittable: false)
          attribute :participant_roles,      Types::Array.of(Curam::ParticipantRoles::ParticipantRole).optional.meta(omittable: true)
          attribute :product_delivery_cases, Types::Array.of(Curam::ProductDeliveryCases::ProductDeliveryCase).optional.meta(omittable: true)
          attribute :last_updated_at,        Types::DateTime.meta(omittable: false)
          attribute :esnap_flag,             Types::Bool

          def as_json(options)
            super(options).merge({
                                   :id => to_param
                                 })
          end

          def persisted?
            true
          end

          def self.model_name
            ActiveModel::Name.new(self, nil, "Case")
          end

          def to_key
            [to_param]
          end

          def to_param
            record_id = ids.detect do |id_entity|
              id_entity.key == ::Curam::SourceSystems::DcasJournal::RECORD_ID_NAMESPACE
            end
            record_id ? record_id.item.to_s : nil
          end

          def aggregate_id
            record_id = ids.detect do |id_entity|
              id_entity.key == ::Curam::SourceSystems::DcasJournal::AGGREGATE_ID_NAMESPACE
            end
            record_id ? record_id.item.to_s : nil
          end

          def id
            record_id = ids.detect do |id_entity|
              id_entity.key == ::Curam::SourceSystems::DcasJournal::RECORD_ID_NAMESPACE
            end
            record_id ? record_id.item.to_s : nil
          end

          def primary_person
            participant_roles.detect(&:primary_client?).person
          end

          def people
            participant_roles.map(&:person).uniq(&:identifiers)
          end
        end
      end
    end
  end
end
