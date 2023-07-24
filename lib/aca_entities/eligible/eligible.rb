# frozen_string_literal: true

module AcaEntities
  # Eligible namespace
  module Eligible
    # TODO: bring visitors from eligible repo
    # Mixin with helpers to support extending dsl
    module Eligible
      def self.included(base)
        base.extend ClassMethods
      end

      # class methods
      module ClassMethods

        def eligibility(name, **options)
          @@eligibilities ||= {}
          @@eligibilities[name] = options[:class_name]
          # attribute name,
          #           const_get(options[:class_name].to_s)
          #             .__send__(:optional)
          #             .__send__(:meta, omittable: true)
        end

        def evidence(name, **options)
          @@evidences ||= {}
          @@evidences[name] = options[:class_name]
        end

        def grant(name, **options)
          @@grants ||= {}
          @@grants[name] = options[:class_name]
        end

        def registered_eligibilities
          @@eligibilities
        end

        def registered_evidences
          @@evidences
        end

        def registered_grants
          @@grants
        end

        def eligibility_resource_for(key)
          registered_eligibilities[key.to_sym]&.constantize || AcaEntities::Eligible::Eligibility
        end

        def evidence_resource_for(key)
          registered_evidences[key.to_sym]&.constantize || AcaEntities::Eligible::Evidence
        end

        def grant_resource_for(key)
          registered_grants[key.to_sym]&.constantize || AcaEntities::Eligible::Grant
        end

        def resource_name_for(type, identifier)
          send("#{type}_resource_for", identifier)
        end
      end
    end

    require 'aca_entities/benefit_sponsors/entities/benefit_sponsorships/benefit_sponsorship'
    require_relative 'entities/state_history'
    require_relative 'entities/value'
    require_relative 'entities/grant'
    require_relative 'entities/evidence'
    require_relative 'entities/eligibility'
    require_relative 'contracts/state_history_contract'
    require_relative 'contracts/value_contract'
    require_relative 'contracts/evidence_contract'
    require_relative 'contracts/grant_contract'
    require_relative 'contracts/eligibility_contract'
    require_relative 'operations/add_evidence'
    require_relative 'operations/add_eligibility'
    require_relative 'operations/add_grant'
    require_relative 'operations/create_evidence_type'
    require_relative 'operations/create_eligibility_type'
    require_relative 'operations/create_grant_type'
  end
end
