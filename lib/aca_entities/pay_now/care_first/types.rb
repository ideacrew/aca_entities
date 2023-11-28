# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module PayNow
    module CareFirst
      # list of types and mappings for CareFirst Pay Now implementation
      module Types
        send(:include, Dry.Types)
        send(:include, Dry::Logic)

        PaynowMemberRelationshipCode = Types::Coercible::String.enum(
          '18',
          '01',
          '53',
          '15',
          '19'
        )

        PaynowMemberRelationshipCodeMap = {
          'self' => '18',
          'spouse' => '01',
          'life_partner' => '53',
          'domestic_partner' => '53',
          'ward' => '15',
          'child' => '19'
          # TODO: map other kinds of dependents to 19
        }.freeze

        PaynowCoverageKindType = Types::Coercible::String.enum(
          'urn:openhbx:terms:v1:qhp_benefit_coverage#health',
          'urn:openhbx:terms:v1:qhp_benefit_coverage#dental'
        )

        SexofIndividualTerminologyType = Types::Coercible::String.enum(
          'F',
          'M',
          'UNDIFFERENTIATED',
          'U'
        )

        SexofIndividualTerminologyTypeMap = {
          'female' => 'F',
          'male' => 'M',
          '' => 'U' # Not known, not observed, not recorded, or refused.
          # '' =>'UNDIFFERENTIATED' # Intersex (mapping does not exist for this in EA currently)
        }.freeze
      end
    end
  end
end