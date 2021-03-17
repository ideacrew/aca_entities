# frozen_string_literal: true

require 'dry-types'

module Qbo::Types
  send(:include, Dry.Types())
  include Dry::Logic

  AccountKind = Types::Coercible::String.enum('Asset', 'Equity', 'Accounts Receivable', 'Liability', 'Revenue')

  AssetAccountKind = Types::Coercible::String.enum('Bank', 'OtherCurrentAsset', 'FixedAsset', 'OtherAsset', 'AccountsReceivable')

  AssetAccountBankKind = Types::Coercible::String.default('CashOnHand'.freeze).enum(
    'CashOnHand',
    'Checking',
    'MoneyMarket',
    'RentsHeldInTrust',
    'Savings',
    'TrustAccounts',
    'CashAndCashEquivalents',
    'OtherEarMarkedBankAccounts'
  )

  AssetAccountOtherCurrentAssetKind = Types::Coercible::String.default('EmployeeCashAdvances').enum(
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

  AssetAccountFixedAssetkKind  = Types::Coercible::String.enum('Accounts Receivable')
  AssetAccountOtherAssetKind  = Types::Coercible::String.enum('Accounts Receivable')
  AssetAccountAccountsReceivableKind  = Types::Coercible::String.enum('Accounts Receivable')

  EquityAccountEquityKind = Types::Coercible::String.default('EmployeeCashAdvances'.freeze).enum('EmployeeCashAdvances')

  ExpenseAccountExpenseKind = Types::Coercible::String.default('EmployeeCashAdvances'.freeze).enum('EmployeeCashAdvances')
  ExpenseAccountOtherExpenseKind = Types::Coercible::String.default('EmployeeCashAdvances'.freeze).enum('EmployeeCashAdvances')
  ExpenseAccountCogsKind = Types::Coercible::String.default('EmployeeCashAdvances'.freeze).enum('EmployeeCashAdvances')

  LiabilityAccountAccountsPayableKind = Types::Coercible::String.default('EmployeeCashAdvances'.freeze).enum('EmployeeCashAdvances')
  LiabilityAccountCreditCardKind = Types::Coercible::String.default('EmployeeCashAdvances'.freeze).enum('EmployeeCashAdvances')
  LiabilityAccountLongTermLiabilityKind = Types::Coercible::String.default('EmployeeCashAdvances'.freeze).enum('EmployeeCashAdvances')
  LiabilityAccountOtherCurrentLiabilityKind = Types::Coercible::String.default('EmployeeCashAdvances'.freeze).enum('EmployeeCashAdvances')

  RevenueAccountIncomeKind = Types::Coercible::String.default('EmployeeCashAdvances'.freeze).enum('EmployeeCashAdvances')
  RevenueAccountOtherIncomeKind = Types::Coercible::String.default('EmployeeCashAdvances'.freeze).enum('EmployeeCashAdvances')

  # Dublin Core Metadata
  DcmiType            = Types::Coercible::Symbol.default(:text).enum(
    :collection,            # A collection is an aggregation of items. The term collection means that the resource is described as a group; its parts may be separately described and navigated.
    :dataset,               # A dataset is information encoded in a defined structure (for example, lists, tables, and databases), intended to be useful for direct machine processing.
    :event,                 # An event is a non-persistent, time-based occurrence. Metadata for an event provides descriptive information that is the basis for discovery of the purpose, location, duration, responsible agents, and links to related events and resources. The resource of type event may not be retrievable if the described instantiation has expired or is yet to occur. Examples - exhibition, web-cast, conference, workshop, open-day, performance, battle, trial, wedding, tea-party, conflagration.
    :image,                 # An image is a primarily symbolic visual representation other than text. For example - images and photographs of physical objects, paintings, prints, drawings, other images and graphics, animations and moving pictures, film, diagrams, maps, musical notation. Note that image may include both electronic and physical representations.
    :interactive_resource,  # An interactive resource is a resource which requires interaction from the user to be understood, executed, or experienced. For example - forms on web pages, applets, multimedia learning objects, chat services, virtual reality.
    :service,               # A service is a system that provides one or more functions of value to the end-user. Examples include: a photocopying service, a banking service, an authentication service, interlibrary loans, a Z39.50 or Web server.
    :software,              # oftware is a computer program in source or compiled form which may be available for installation non-transiently on another machine. For software which exists only to create an interactive environment, use interactive instead.
    :sound,                 # A sound is a resource whose content is primarily intended to be rendered as audio. For example - a music playback file format, an audio compact disc, and recorded speech or sounds.
    :text,                  # A text is a resource whose content is primarily words for reading. For example - books, letters, dissertations, poems, newspapers, articles, archives of mailing lists. Note that facsimiles or images of texts are still of the genre text.
  )

  DcmiNamespaces      = Types::Coercible::Symbol.enum(
    "http://purl.org/dc/elements/1.1/",
    "http://purl.org/dc/terms/",
    "http://purl.org/dc/dcmitype/",
    "http://purl.org/dc/dcam/"
  )

  # OSHA Types
  BinaryGenderKind    = Types::Coercible::Symbol.enum(:male, :female)
  ContactCaseKind     = Types::Coercible::Symbol.enum(:contact_exposure_case, :contact_index_case)
  WorkRelatedKind     = Types::Coercible::Symbol.enum(:contact_exposure_case, :contact_index_case)

  AccountCategoryKind = Types::Coercible::Symbol.enum(:my_organization, :contact_employer, :health_care_provider, :public_health_agency, :testing_lab, :vendor, :other)
  ContactCategoryKind = Types::Coercible::Symbol.enum(:contact_representative, :contractor, :customer, :employee, :faculty, :guest, :health_care_provider, :public_health_agency_reppresentative, :staff, :student, :other)

  Duration            = Types.Constructor(ActiveSupport::Duration) {|val| ActiveSupport::Duration.build(val) }

  # E.164 Standard
  PhoneNumber       = Types::String.constrained(format: /^\+(?:[0-9] ?){6,14}[0-9]$/)
  # PhoneNumber       = Types::String.constrained(format: /^\+\d{1,3}\s\d{1,14}(\s\d{1,13})$/)
  # PhoneNumber       = Types::String.constrained(format: /^\+\d{1,3}\s\d{1,14}(\s\d{1,13})?/)

  Email             = Types::String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  EmailOrString     = Types::Email | Types::String

  Stores            = Types::String.default('file_store'.freeze).enum('file_store')

  CallableDate      = Types::Date.default { Date.today }
  CallableDateTime  = Types::DateTime.default { DateTime.now }

  HashOrNil         = Types::Hash | Types::Nil
  StringOrNil       = Types::String | Types::Nil

  RequiredString    = Types::Strict::String.constrained(min_size: 1)
  StrippedString    = Types::String.constructor(&:strip)
  SymbolOrString    = Types::Symbol | Types::String
  NilOrString       = Types::Nil | Types::String

  CoercedInteger    = Types::Coercible::Integer | Types::Coercible::Float.constructor(&:to_i)

  StrictSymbolizingHash = Types::Hash.schema({}).strict.with_key_transform(&:to_sym)

  Callable   = Types.Interface(:call)
end
