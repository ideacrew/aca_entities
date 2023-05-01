# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      module Contracts
        # Contract for MemberName
        class MemberNameContract < Dry::Validation::Contract
          params do
            required(:person_surname).filled(:string)
            required(:person_given_name).filled(:string)
            optional(:person_middle_name).maybe(:string)
            optional(:person_full_name).maybe(:string)
            optional(:person_name_prefix_text).maybe(:string)
            optional(:person_name_suffix_text).maybe(:string)
            optional(:person_alternate_name).maybe(:string)
          end
        end
      end
    end
  end
end
