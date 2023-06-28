
module AcaEntities
  module Eligible
    # module for State Histories
    module History
      def self.included(base)        
        base.class_eval do
          attribute :state_histories, Types::Array.of(AcaEntities::Eligible::StateHistory).meta(omittable: false)

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
            site_histories.sort_by(&:transition_at).last
          end
        end
      end
    end
  end
end
