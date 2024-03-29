# frozen_string_literal: true

require "active_support/inflector"
require_relative "entities/state_history"
require_relative "entities/value"
require_relative "entities/grant"
require_relative "entities/evidence"
require_relative "entities/eligibility"
require_relative "contracts/contract"
require_relative "contracts/state_history_contract"
require_relative "contracts/value_contract"
require_relative "contracts/evidence_contract"
require_relative "contracts/grant_contract"
require_relative "contracts/eligibility_contract"
require_relative "operations/add_evidence"
require_relative "operations/add_eligibility"
require_relative "operations/add_grant"
require_relative "operations/state_change_validator"
require_relative "operations/create_evidence_type"
require_relative "operations/create_eligibility_type"
require_relative "operations/create_grant_type"

module AcaEntities
  # Eligible namespace
  module Eligible
    # TODO: bring visitors from eligible repo
    # Mixin with helpers to support extending dsl
    module Eligible
      def self.included(base)
        base.class_eval do
          # @!attribute [r] eligibilities
          # Collection of eligibilities
          # @return [Arrray]
          attribute :eligibilities,
                    Types::Array.of(AcaEntities::Eligible::Eligibility).meta(
                      omittable: true
                    )
        end

        base.extend(ClassMethods)
      end

      # class methods
      module ClassMethods
        ResourceReference = Struct.new(:class_name, :optional, :meta)

        def resource_ref_dir
          @resource_ref_dir ||= Concurrent::Map.new
        end

        def register(resource_kind, name, options)
          resource_set = resource_kind.to_s.pluralize
          resource_ref_dir[resource_set.to_sym] ||= {}
          resource_ref_dir[resource_set.to_sym][name] = ResourceReference.new(
            options[:class_name],
            options[:optional],
            options[:meta]
          )
        end

        def eligibility(name, **options)
          register(:eligibility, name, options)
        end

        def eligibility_resource_for(key)
          if resource_ref_dir[
            :eligibilities
          ]
            resource =
              resource_ref_dir[:eligibilities][key.to_sym]
          end
          return AcaEntities::Eligible::Eligibility unless resource
          resource.class_name.constantize
        end

        def resource_name_for(type, identifier)
          send("#{type}_resource_for", identifier)
        end
      end
    end
  end
end

require "aca_entities/benefit_sponsors/entities/benefit_sponsorships/benefit_sponsorship"
