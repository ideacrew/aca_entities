# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'
require 'bigdecimal'
require 'bigdecimal/util'
require 'dry-types'
module AcaEntities
  module Ledger
    # Premium Billing Custom Data Types
    module Types
      send(:include, Dry.Types)
      include Dry::Logic

      AccountCustomerRole = Types::Coercible::String.enum('subscriber', 'custodial_parent', 'responsible_person')
      UserFeeReportItemKind = Types::Coercible::String.enum('adjustment', 'fee')
      EnrollmentTransition =
        Types::Coercible::String.enum(
          'active',
          'term',
          'reinstate',
          'initial',
          'current_month_term',
          'current_month_drop_term',
          'current_month_new_and_term'
        )
      InsuranceProductKind = Types::Coercible::String.enum('health', 'dental')

      PartyRoleKind = Types::Coercible::String.enum('person', 'organization')
      PersonPartyRoleRelationshipKind = Types::Coercible::String.enum('subscriber', 'billing_contact')
      OrganizationRolePartyRelationshipKind = Types::Coercible::String.enum('insurer', 'state_based_marketplace')
      AllPartyRoleRelationshipKind = PersonPartyRoleRelationshipKind | OrganizationRolePartyRelationshipKind

      # Keepr gem account kinds
      KeeprAccountKind =
        Types::Coercible::Symbol.enum(:asset, :liability, :revenue, :expense, :forward, :debtor, :creditor)

      KeeprSideKind = Types::Coercible::String.enum('credit', 'debit')

      AssetAccountKind =
        Types::Coercible::String.enum(
          'bank',
          'other_current_asset',
          'fixed_asset',
          'other_asset',
          'accounts_receivable'
        )

      AssetAccountBankKind =
        Types::Coercible::String
          .default('cash_on_hand')
          .enum(
            'cash_on_hand',
            'checking',
            'money_market',
            'rents_held_in_trust',
            'savings',
            'trust_accounts',
            'cash_and_cash_equivalents',
            'other_earmarked_bank_accounts'
          )

      AssetAccountOtherCurrentAssetKind =
        Types::Coercible::String
          .default('EmployeeCashAdvances')
          .enum(
            'AllowanceForBadDebts',
            'DevelopmentCosts',
            'EmployeeCashAdvances',
            'OtherCurrentAssets',
            'Inventory',
            'Investment_MortgageRealEstateLoans',
            'Investment_Other',
            'Investment_TaxExemptSecurities',
            'Investment_USGovernmentObligations',
            'LoansToOfficers',
            'LoansToOthers',
            'LoansToStockholders',
            'PrepaidExpenses',
            'Retainage',
            'UndepositedFunds',
            'AssetsAvailableForSale',
            'BalWithGovtAuthorities',
            'CalledUpShareCapitalNotPaid',
            'ExpenditureAuthorisationsAndLettersOfCredit',
            'GlobalTaxDeferred',
            'GlobalTaxRefund',
            'InternalTransfers',
            'OtherConsumables',
            'ProvisionsCurrentAssets',
            'ShortTermInvestmentsInRelatedParties',
            'ShortTermLoansAndAdvancesToRelatedParties',
            'TradeAndOtherReceivables'
          )
    end
  end
end
