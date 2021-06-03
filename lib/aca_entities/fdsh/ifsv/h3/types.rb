# frozen_string_literal: true
require 'dry-types'

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        # Extend DryTypes to include MagiMedicaid
        # rubocop:disable Metrics/ModuleLength
        module Types
          send(:include, Dry.Types)
          include Dry::Logic

          TaxReturnFilingStatusCode = {
            "0": 'Single, Filing Declaration of Estimated Income Tax',
            "1": 'Single Taxpayer',
            "2": 'Married Taxpayer filing Joint Return',
            "3":
              'Married Taxpayer filing a Separate Return (Spouse exemption is NOT claimed)',
            "4": 'Head of Household (Claiming Dependent)',
            "5": 'Widow(er) with a Dependent Child',
            "6":
              'Married Taxpayer filing a Separate Return (Spouse exemption IS claimed)',
            "7": 'Head of Household (Dependent is NOT Claimed)'
          }

          TaxFilerType = (TaxFiler PrimaryTaxFiler SpouseTaxFiler)
          TaxFilerCategoryCodeType =
            Types::Coercible::String.enum('PRIMARY', 'SPOUSE', 'DEPENDENT')

          # run through validation code
          FullyRestrictedSSNType = nil # regex: ([1-57-8][0-9]{2}|0([1-9][0-9]|[0-9][1-9])|6([0-57-9][0-9]|[0-9][0-57-9]))([1-9][0-9]|[0-9][1-9])([1-9]\d{3}|\d[1-9]\d{2}|\d{2}[1-9]\d|\d{3}[1-9])

          BenefitKind =
            Types::Coercible::String.enum('acf_refugee_medical_assistance')

          RequestIDType = Types::Coercible::Integer # 1 -9 chars

          TaxReturnYearType = Types::Coercible::Integer # # 1000 -> 9999
        end
      end
    end
  end
end
