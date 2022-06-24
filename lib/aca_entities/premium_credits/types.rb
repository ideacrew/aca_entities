# frozen_string_literal: true

require 'dry-types'
require 'bigdecimal'

module AcaEntities
  module PremiumCredits
    # Extend DryTypes
    module Types
      include Dry.Types
      include Dry::Logic

      # Different kinds of Group Premium Credits
      GroupKind = Types::Coercible::String.enum(
        'aptc_csr'
        # 'employer_contribution',
      )

      # Different kinds of Member Premium Credits.
      MemberKind = Types::Coercible::String.enum(
        'aptc_eligible',
        'csr'
      )

    end
  end
end
