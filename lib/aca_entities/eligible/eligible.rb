
module AcaEntities
  module Eligible
    module Eligible

      def self.included(base)
        base.extend ClassMethods
      end
    
      module ClassMethods
        def eligibility(*eligibility_types)
          # eligibility_types.each do |eligibility_type|
          #   define_method("#{eligibility_type}?") do
          #     self.evidence_gid == evidence_gid
          #   end
          # end
        end

        def evidence(*evidence_types)
          # evidence_types.each do |evidence_type|
          #   define_method("#{evidence_type}?") do
          #     self.evidence_gid == evidence_gid
          #   end
          # end
        end

        def grant(*grant_types)
          # grant_types.each do |grant_type|
          #   define_method("#{grant_type}?") do
          #     self.evidence_gid == evidence_gid
          #   end
          # end
        end
      end   
    end
  end
end
