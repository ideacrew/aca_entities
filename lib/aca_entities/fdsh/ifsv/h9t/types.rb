# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        # Extend DryTypes to include FDSI IFSV
        module Types
          send(:include, Dry.Types)
          include Dry::Logic

          BenefitKind =
            Types::Coercible::String.enum('acf_refugee_medical_assistance')

          TaxFilerCategoryCodeKind =
            Types::Coercible::String.enum('PRIMARY', 'SPOUSE', 'DEPENDENT')
              .freeze

          TaxFilerType =
            Types::Coercible::String.enum(
              'TaxFiler',
              'PrimaryTaxFiler',
              'SpouseTaxFiler'
            ).freeze

          TaxReturnFilingStatusCodeKind =
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

          Code = {
            'HE020001' => 'Systemic Error',
            'HE020002' => 'Unable to provide data due to authentication issue',
            'HE020003' => 'Unable to provide income data due to spouse mismatch',
            'HE020004' => 'Return information is unavailable',
            'HE020009' => 'Tax household has a valid filing extension and has not reconciled APTC',
            'HE020010' => 'Tax household filed a tax return and did not reconcile APTC'
          }.freeze

          ResponseCodeKind = {
            :'004' => 'Return information is unavailable',
            :'008' => 'No dependent filing requirement'
          }.freeze

        end
      end
    end
  end
end
