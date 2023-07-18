# frozen_string_literal: true

module AcaEntities
  module Eligible
    # module for Grant
    module Grant
      def self.included(base)
        base.class_eval do
          attribute :key, Types::Symbol.meta(omittable: false) # currently stored as :osse_subsidy
          attribute :title, Types::String.meta(omittable: false)
          attribute :description?, Types::String.optional.meta(omittable: true)
          attribute :value, AcaEntities::Eligible::Value # replaces aasm_state attribute

          # attribute :is_satisfied, Types::Bool.optional.meta(omittable: false) # helper value when current state value is satisfied
          attribute :state_histories,
                    Types::Array
                      .of(AcaEntities::Eligible::StateHistory)
                      .meta(omittable: false)
          attribute :timestamp,
                    AcaEntities::TimeStamp.optional.meta(omittable: true)

          def latest_is_eligible
            latest_history&.is_eligible
          end

          def latest_effective_on
            latest_history&.effective_on
          end

          def latest_state
            latest_history&.to_state
          end

          def latest_history
            site_histories.max_by(&:transition_at)
          end
        end
      end
    end
  end
end
