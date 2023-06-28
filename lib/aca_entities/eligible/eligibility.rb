
module AcaEntities
  module Eligible
    # module for Eligibility
    module Eligibility

      def self.included(base)
        base.class_eval do
          # nest attributes with eligibility sth like
          # attribute :eligibility do
          # end

          attribute :key, Types::Symbol.meta(omittable: false)
          attribute :title, Types::String.meta(omittable: false)  
          attribute :description?, Types::String.optional.meta(omittable: true)
          attribute :timestamp, AcaEntities::TimeStamp.optional.meta(omittable: true)
        end
      end
    end
  end
end

