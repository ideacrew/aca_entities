# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        # Extend DryTypes to include FDSI IFSV
        module Types
          send(:include, Dry.Types)
          include Dry::Logic

          BenefitKind =
            Types::Coercible::String.enum('acf_refugee_medical_assistance')

          RequestIDType = Types::Coercible::String # Integer # 1 -9 chars

          TaxFilerCategoryCodeKind =
            Types::Coercible::String.enum('PRIMARY', 'SPOUSE', 'DEPENDENT')
              .freeze

          TaxFilerType =
            Types::Coercible::String.enum(
              'TaxFiler',
              'PrimaryTaxFiler',
              'SpouseTaxFiler'
            ).freeze

          TaxReturnFilingStatusCode =
            Types::Coercible::String.enum(
              '0', #: 'Single, Filing Declaration of Estimated Income Tax',
              '1', #: 'Single Taxpayer',
              '2', #: 'Married Taxpayer filing Joint Return',
              '3', #: 'Married Taxpayer filing a Separate Return (Spouse exemption is NOT claimed)',
              '4', #: 'Head of Household (Claiming Dependent)',
              '5', #: 'Widow(er) with a Dependent Child',
              '6', #: 'Married Taxpayer filing a Separate Return (Spouse exemption IS claimed)',
              '7' #: 'Head of Household (Dependent is NOT Claimed)'
            ).freeze

          TaxReturnYearType = Types::Coercible::Integer # # 1000 -> 9999
        end
      end
    end
  end
end
