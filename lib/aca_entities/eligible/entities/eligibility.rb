# frozen_string_literal: true

module AcaEntities
  module Eligible
    # entity class for Eligibility
    class Eligibility < Dry::Struct
      INELIGIBLE_STATUSES = %i[initial ineligible].freeze
      ELIGIBLE_STATUSES = %i[eligible].freeze
      EVENTS = %i[move_to_eligible move_to_ineligible].freeze
      STATE_TRANSITION_MAP = {
        eligible: %i[initial eligible ineligible],
        ineligible: %i[initial eligible ineligible]
      }.freeze

      # @!attribute [r] _id
      # An id reference to this Eligibility
      # @return [String]
      attribute? :_id, Types::Coercible::String.optional.meta(omittable: true)

      # @!attribute [r] key
      # An unambiguous reference to this Eligibility
      # @return [Symbol]
      attribute :key, Types::Coercible::String.meta(omittable: false)

      # @!attribute [r] title
      # A name given to the resource by which the resource is formally known
      # @return [String]
      attribute :title, Types::String.meta(omittable: false)

      # @!attribute [r] description
      # An optional account of the content of this resource
      # @return [String]
      attribute? :description, Types::String.optional.meta(omittable: true)

      # @!attribute [r] current_state
      # CurrentState of the resource
      # @return [Symbol]
      attribute :current_state, Types::Symbol.meta(omittable: false)

      # @!attribute [r] evidences
      # Collection of evidences for the eligibility
      # @return [Arrray]
      attribute :evidences,
                Types::Array.of(AcaEntities::Eligible::Evidence).meta(
                  omittable: false
                )

      # @!attribute [r] grants
      # Collection of grants available for the eligibility
      # @return [Arrray]
      attribute :grants,
                Types::Array.of(AcaEntities::Eligible::Grant).meta(
                  omittable: false
                )

      # @!attribute [r] state_histories
      # Collection of resource historical states and associated eligibility
      # @return [Array]
      attribute :state_histories,
                Types::Array.of(AcaEntities::Eligible::StateHistory).meta(
                  omittable: false
                )

      # @!attribute [r] timestamp
      # Timestamp of the resource ie. submitted, created or modified time of the resource
      # @return [Timestamp]
      attribute :timestamps,
                AcaEntities::TimeStamp.optional.meta(omittable: true)

      def eligibility_state_handler
        @eligibility_state_handler ||=
          AcaEntities::Eligible::StateHandlers::EligibilityStateHandler.new(
            self
          )
      end

      class << self
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

        def evidence(name, **options)
          register(:evidence, name, options)
        end

        def grant(name, **options)
          register(:grant, name, options)
        end

        def evidence_resource_for(key)
          if resource_ref_dir[
            :evidences
          ]
            resource =
              resource_ref_dir[:evidences][key.to_sym]
          end
          return AcaEntities::Eligible::Evidence unless resource
          resource.class_name.constantize
        end

        def grant_resource_for(key)
          resource = resource_ref_dir[:grants][key.to_sym] if resource_ref_dir[
            :grants
          ]
          return AcaEntities::Eligible::Grant unless resource
          resource.class_name.constantize
        end

        def resource_name_for(type, identifier)
          send("#{type}_resource_for", identifier)
        end
      end
    end
  end
end
