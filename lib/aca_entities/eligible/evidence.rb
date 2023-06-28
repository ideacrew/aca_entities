
module AcaEntities
  module Eligible
    # module for Evidence
    module Evidence

      def self.included(base)
        base.class_eval do
          attribute :key, Types::Symbol.meta(omittable: false) # currently stored as :osse_subsidy
          attribute :title, Types::String.meta(omittable: false)  
          attribute :description?, Types::String.optional.meta(omittable: true)
          attribute :is_satisfied, Types::Bool.optional.meta(omittable: false) # helper value when current state value is satisfied
          attribute :timestamp, AcaEntities::TimeStamp.optional.meta(omittable: true)
        end
      end
    end
  end
end
