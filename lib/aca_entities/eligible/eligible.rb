module AcaEntities
  module Eligible
    # TODO: bring visitors from eligible repo

    module Eligible
      def self.included(base)
        base.extend ClassMethods
      end

      # def evidence(name, **options)
      #   options.symbolize_keys!
      #   options[:class_name].constantize

      #   # evidence_types.each do |evidence_type|
      #   #   define_method("#{evidence_type}?") do
      #   #     self.evidence_gid == evidence_gid
      #   #   end
      #   # end
      # end

      module ClassMethods
        def eligibility(*eligibility_types)
          # eligibility_types.each do |eligibility_type|
          #   define_method("#{eligibility_type}?") do
          #     self.evidence_gid == evidence_gid
          #   end
          # end
        end

        def evidence(name, **options)
          attribute name, const_get(options[:class_name].constantize)
        end

        def grant(*grant_types)
          attribute name, const_get(options[:class_name].constantize)
        end
      end
    end

    require_relative 'grant'
    require_relative 'evidence'
    require_relative 'eligibility'
    require_relative 'state_history'
    require_relative 'shop_osse_grant'
    require_relative 'shop_osse_evidence'
    require_relative 'shop_osse_eligibility'
  end
end
