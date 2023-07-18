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
          attribute name,
                    const_get(options[:class_name].to_s)
                      .__send__(:optional)
                      .__send__(:meta, omittable: true)
        end

        def evidence(name, **options)
          attribute name,
                    const_get(options[:class_name].to_s)
                      .__send__(:optional)
                      .__send__(:meta, omittable: true)
        end

        def grant(name, **options)
          attribute name,
                    const_get(options[:class_name].to_s)
                      .__send__(:optional)
                      .__send__(:meta, omittable: true)
        end
      end
    end

    require_relative 'state_history'
    require_relative 'value'
    require_relative 'grant'
    require_relative 'evidence'
    require_relative 'eligibility'
    require_relative 'contracts/state_history_contract'
    require_relative 'contracts/value_contract'
  end
end
