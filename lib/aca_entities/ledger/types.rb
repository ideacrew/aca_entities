# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Ledger
    # rubocop:disable Layout/LineLength
    # custom Qbo types
    module Types
      send(:include, Dry.Types)
      include Dry::Logic

      UserFeeReportItemKind = Types::Coercible::String.enum('adjustment', 'fee')
      InsuranceProductKind = Types::Coercible::String.enum('health', 'dental')

      PartyRoleKind = Types::Coercible::String.enum('person', 'organization')
      PersonPartyRoleRelationshipKind = Types::Coercible::String.enum('subscriber', 'billing_contact')
      OrganizationRolePartyRelationshipKind = Types::Coercible::String.enum('carrier', 'state_based_marketplace')
      AllPartyRoleRelationshipKind = PersonPartyRoleRelationshipKind | OrganizationRolePartyRelationshipKind

      AccountCategoryKind =
        Types::Coercible::String.enum('asset', 'equity', 'accounts_receivable', 'liability', 'revenue')

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

      # Duration            = Types.Constructor(::ActiveSupport::Duration) {|val| ::ActiveSupport::Duration.build(val) }

      # E.164 Standard
      PhoneNumber = Types::String.constrained(format: /^\+(?:[0-9] ?){6,14}[0-9]$/)

      # PhoneNumber       = Types::String.constrained(format: /^\+\d{1,3}\s\d{1,14}(\s\d{1,13})$/)
      # PhoneNumber       = Types::String.constrained(format: /^\+\d{1,3}\s\d{1,14}(\s\d{1,13})?/)

      Email = Types::String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      EmailOrString = Types::Email | Types::String

      Stores = Types::String.default('file_store').enum('file_store')

      CallableDate = Types::Date.default { Date.today }
      CallableDateTime = Types::DateTime.default { DateTime.now }

      HashOrNil = Types::Hash | Types::Nil
      StringOrNil = Types::String | Types::Nil

      RequiredString = Types::Strict::String.constrained(min_size: 1)
      StrippedString = Types::String.constructor(&:strip)
      SymbolOrString = Types::Symbol | Types::String
      NilOrString = Types::Nil | Types::String

      CoercedInteger = Types::Coercible::Integer | Types::Coercible::Float.constructor(&:to_i)

      StrictSymbolizingHash = Types::Hash.schema({}).strict.with_key_transform(&:to_sym)

      Callable = Types.Interface(:call)
    end
    # rubocop:enable Layout/LineLength
  end
end
