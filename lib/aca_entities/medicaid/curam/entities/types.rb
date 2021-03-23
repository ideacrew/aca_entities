# frozen_string_literal: true

require 'dry-types'
require 'date'

module AcaEntities
  module Medicaid
    module Curam
      # rubocop:disable Metrics/ModuleLength, Layout/LineLength
      # custom types for curam
      module Types
        send(:include, Dry.Types())
        send(:include, Dry::Logic)

        module Types
          send(:include, Dry.Types())
        end

        # Dublin Core Metadata

        DcmiType = Types::Coercible::Symbol.default('text').enum(
          :collection,            # A collection is an aggregation of items. The term collection means that the resource is described as a group; its parts may be separately described and navigated.
          :dataset,               # A dataset is information encoded in a defined structure (for example, lists, tables, and databases), intended to be useful for direct machine processing.
          :event,                 # An event is a non-persistent, time-based occurrence. Metadata for an event provides descriptive information that is the basis for discovery of the purpose, location, duration, responsible agents, and links to related events and resources. The resource of type event may not be retrievable if the described instantiation has expired or is yet to occur. Examples - exhibition, web-cast, conference, workshop, open-day, performance, battle, trial, wedding, tea-party, conflagration.
          :image,                 # An image is a primarily symbolic visual representation other than text. For example - images and photographs of physical objects, paintings, prints, drawings, other images and graphics, animations and moving pictures, film, diagrams, maps, musical notation. Note that image may include both electronic and physical representations.
          :interactive_resource,  # An interactive resource is a resource which requires interaction from the user to be understood, executed, or experienced. For example - forms on web pages, applets, multimedia learning objects, chat services, virtual reality.
          :service,               # A service is a system that provides one or more functions of value to the end-user. Examples include: a photocopying service, a banking service, an authentication service, interlibrary loans, a Z39.50 or Web server.
          :software,              # oftware is a computer program in source or compiled form which may be available for installation non-transiently on another machine. For software which exists only to create an interactive environment, use interactive instead.
          :sound,                 # A sound is a resource whose content is primarily intended to be rendered as audio. For example - a music playback file format, an audio compact disc, and recorded speech or sounds.
          :text                  # A text is a resource whose content is primarily words for reading. For example - books, letters, dissertations, poems, newspapers, articles, archives of mailing lists. Note that facsimiles or images of texts are still of the genre text.
        )

        DcmiNamespaces = Types::Coercible::Symbol.enum(
          "http://purl.org/dc/elements/1.1/",
          "http://purl.org/dc/terms/",
          "http://purl.org/dc/dcmitype/",
          "http://purl.org/dc/dcam/"
        )

        AddressKind = Types::String.enum(
          'urn:openhbx:terms:v1:address_type#home',
          'urn:openhbx:terms:v1:address_type#mailing',
          'urn:openhbx:terms:v1:address_type#work'
        )

        # We'll re-enable this later, once we have the full set,
        # but this enumerated type actually has many, many values
        # values and I discovered this excluding quite a large amount
        # of valid data

        ApplicantParticipantRoleKind = Types::String

        # Types::String.enum(
        #  'Expense Contributor',
        #  'Nominee',
        #  'Primary Client',
        #  'Verification Provider'
        # )

        ApplicantTypeCodeKind = Types::String

        # Types::String.enum(
        #  'EXC',
        #  'NOM',
        #  'PRI',
        #  'VER',
        # )

        # Actually incorrect, many records can have status 'deleted', amoung others
        ApplicantRecordStatusKind = Types::String # .enum(

        # ApplicantRecordStatusKind = Types::String.enum(
        #  'Active'
        # )

        ApplicantRecordStatusCodeKind = Types::String
        # ApplicantRecordStatusCodeKind = Types::String.enum(
        #   'RST1'
        # )

        ApplicationStatusKind = Types::String

        # ApplicationStatusKind = Types::String.enum(
        #  'Disposed',
        #  'Ready for Determination'
        # )

        ApplicationStatusCodeKind = Types::String
        # ApplicationStatusCodeKind = Types::String.enum(
        #  'AS19004',
        #  'AS19005'
        # )

        ProgramApplicationTypeKind = Types::String
        # ProgramApplicationTypeKind = Types::String.enum(
        #   'Food Assistance',
        #   'Cash Assistance'
        # )

        ProgramApplicationTypeCodeKind = Types::String

        # ProgramApplicationTypeCodeKind = Types::String.enum(
        #   'PT19001',
        #   'PT19002'
        # )

        ProgramApplicationStatusCodeKind = Types::String

        # ProgramApplicationStatusCodeKind = Types::String.enum(
        #   'PS19001',
        #   'PS19003'
        # )

        ProgramApplicationStatusKind = Types::String

        # ProgramApplicationStatusKind = Types::String.enum(
        #   'Approved',
        #   'Pending'
        # )

        ProductNameKind = Types::String.enum(
          'SNAP/Transitional SNAP',
          'Local SNAP Supplement',
          'Low Income Home Energy Assistance Program'
        )

        ProductTypeKind = Types::String.enum(
          'Food Assistance',
          'LSS',
          'LIHEAP'
        )

        EvidenceStatusType = Types::String

        # EvidenceStatusType = Types::String.enum(
        #   'Active',
        #   'Deleted',
        #   'Superseded'
        # )

        EvidenceCategoryKind = Types::String

        # EvidenceCategoryKind  = Types::String.enum(
        #   'Benefit',
        #   'Earned',
        #   'Unearned'
        # )

        EvidenceIncomeTypeKind = Types::String

        # EvidenceIncomeTypeKind = Types::String.enum(
        #   'Social Security Retirement',
        #   'SSI',
        #   'On Job Training',
        #  'Government housing subsidies',
        #   'Agriculture and Stabilization and Conservation (ACSE) Payments',
        #   'Other Non-countable income/payments excluded under federal statute',
        #   'Annuity',
        #   'Retirement/Pension',
        #   'Alimony',
        #   'Adoption Subsidy'
        # )

        EvidenceTypeCodeKind = Types::String

        # EvidenceTypeCodeKind = Types::String.enum(
        #   'BT40',
        #   'BT6',
        #   'DCHXUI131',
        #   'DCHXUI151',
        #   'ET60',
        #   'UI27',
        #   'UI3',
        #   'UI4',
        #   'UI5',
        #   'UI71'
        # )

        EvidenceIncomeFrequencyKind = Types::String

        # EvidenceIncomeFrequencyKind = Types::String.enum(
        #   'Bi-Weekly',
        #   'Monthly',
        #   'Weekly'
        # )

        EvidenceFrequencyCodeKind = Types::String

        # EvidenceFrequencyCodeKind = Types::String.enum(
        #   'FC2',
        #   'FC3',
        #   'FC6'
        # )

        ParticipantRoleStatusKind = Types::String

        # ParticipantRoleStatusKind = Types::String.enum(
        #   'Active'
        # )

        ParticipantRoleStatusCodeKind = Types::String

        # ParticipantRoleStatusCodeKind = Types::String.enum(
        #   'RST1'
        # )

        ParticipantRoleNameKind = Types::String

        # ParticipantRoleNameKind = Types::String.enum(
        #   'Expense Contributor',
        #   'Nominee',
        #   'Primary Client',
        #   'Verification Provider'
        # )

        ParticipantRoleTypeCodeKind = Types::String

        # ParticipantRoleTypeCodeKind = Types::String.enum(
        #   'EXC',
        #   'NOM',
        #   'PRI',
        #   'VER',
        # )

        PhoneKind = Types::String.enum(
          'urn:openhbx:terms:v1:phone_type#home',
          'urn:openhbx:terms:v1:phone_type#work',
          'urn:openhbx:terms:v1:phone_type#mobile',
          'urn:openhbx:terms:v1:phone_type#pager',
          'urn:openhbx:terms:v1:phone_type#main',
          'urn:openhbx:terms:v1:phone_type#fax',
          'urn:openhbx:terms:v1:phone_type#other'
        )

        EmailKind = Types::String.enum(
          'urn:openhbx:terms:v1:email_type#home',
          'urn:openhbx:terms:v1:email_type#work'
        )

        FamilyRelationshipKind = Types::String.enum(
          'urn:openhbx:terms:v1:individual_relationship#self',
          'urn:openhbx:terms:v1:individual_relationship#spouse',
          'urn:openhbx:terms:v1:individual_relationship#child',
          'urn:openhbx:terms:v1:individual_relationship#parent',
          'urn:openhbx:terms:v1:individual_relationship#grandparent',
          'urn:openhbx:terms:v1:individual_relationship#grandchild',
          'urn:openhbx:terms:v1:individual_relationship#great_grandparent',
          'urn:openhbx:terms:v1:individual_relationship#great_grandchild',
          'urn:openhbx:terms:v1:individual_relationship#aunt_or_uncle',
          'urn:openhbx:terms:v1:individual_relationship#nephew_or_niece',
          'urn:openhbx:terms:v1:individual_relationship#cousin',
          'urn:openhbx:terms:v1:individual_relationship#adopted_child',
          'urn:openhbx:terms:v1:individual_relationship#foster_child',
          'urn:openhbx:terms:v1:individual_relationship#daughter_or_son_in_law',
          'urn:openhbx:terms:v1:individual_relationship#brother_or_sister_in_law',
          'urn:openhbx:terms:v1:individual_relationship#father_or_mother_in_law',
          'urn:openhbx:terms:v1:individual_relationship#sibling',
          'urn:openhbx:terms:v1:individual_relationship#ward',
          'urn:openhbx:terms:v1:individual_relationship#stepparent',
          'urn:openhbx:terms:v1:individual_relationship#stepchild',
          'urn:openhbx:terms:v1:individual_relationship#sponsored_dependent',
          'urn:openhbx:terms:v1:individual_relationship#dependent_of_a_minor_dependent',
          'urn:openhbx:terms:v1:individual_relationship#ex-spouse',
          'urn:openhbx:terms:v1:individual_relationship#guardian',
          'urn:openhbx:terms:v1:individual_relationship#court_appointed_guardian',
          'urn:openhbx:terms:v1:individual_relationship#collateral_dependent',
          'urn:openhbx:terms:v1:individual_relationship#life_partner',
          'urn:openhbx:terms:v1:individual_relationship#domestic_partner',
          'urn:openhbx:terms:v1:individual_relationship#annuitant',
          'urn:openhbx:terms:v1:individual_relationship#trustee',
          'urn:openhbx:terms:v1:individual_relationship#other_relationship',
          'urn:openhbx:terms:v1:individual_relationship#other_relative'
        )

        IncomeUriNamespace = 'urn:openhbx:terms:v1:income#'

        IncomeTypeKind = Types::String.enum(
          'alimony_and_maintenance',
          'american_indian_and_alaskan_native',
          'capital_gains',
          'dividend',
          'employer_funded_disability',
          'estate_trust',
          'farming_and_fishing',
          'foreign',
          'interest',
          'lump_sum_amount',
          'military',
          'net_self_employment',
          'other',
          'pension_retirement_benefits',
          'permanent_workers_compensation',
          'prizes_and_awards',
          'rental_and_royalty',
          'scholorship_payments',
          'social_security_benefit',
          'social_security_disability_income',
          'social_security_retirement',
          'supplemental_security_income',
          'tax_exempt_interest',
          'unemployment_insurance',
          'wages_and_salaries',
          'income_from_irs',
          'title_monthly',
          'title_yearly',
          'strike_benefits',
          'retro_income'
        )

        IncomeFrequencyKind = Types::Strict::String.enum(
          'urn:openhbx:terms:v1:income_frequency#biweekly',
          'urn:openhbx:terms:v1:income_frequency#daily',
          'urn:openhbx:terms:v1:income_frequency#half_yearly',
          'urn:openhbx:terms:v1:income_frequency#monthly',
          'urn:openhbx:terms:v1:income_frequency#quarterly',
          'urn:openhbx:terms:v1:income_frequency#weekly',
          'urn:openhbx:terms:v1:income_frequency#yearly'
        )

        TaxFilingStatusKind = Types::String.enum(
          'urn:openhbx:terms:v1:tax_filer#tax_filer',
          'urn:openhbx:terms:v1:tax_filer#single',
          'urn:openhbx:terms:v1:tax_filer#joint',
          'urn:openhbx:terms:v1:tax_filer#separate',
          'urn:openhbx:terms:v1:tax_filer#dependent',
          'urn:openhbx:terms:v1:tax_filer#non-filer'
        )

        CitizenStatusKind = Types::String.enum(
          'urn:openhbx:terms:v1:citizen_status#us_citizen',
          'urn:openhbx:terms:v1:citizen_status#naturalized_citizen',
          'urn:openhbx:terms:v1:citizen_status#alien_lawfully_present',
          'urn:openhbx:terms:v1:citizen_status#lawful_permanent_resident',
          'urn:openhbx:terms:v1:citizen_status#indian_tribe_member',
          'urn:openhbx:terms:v1:citizen_status#not_lawfully_present_in_us',
          'urn:openhbx:terms:v1:citizen_status#undocumented_immigrant'
        )

        GenderKinds = Types::String.enum(
          'Male',
          'Female',
          'Unknown'
        )

        ResidencyStatusKind = Types::String.enum(
          'urn:openhbx:terms:v1:address_verification#ADDRESS_NOT_IN_AREA',
          'urn:openhbx:terms:v1:address_verification#ADDRESS_IN_AREA'
        )

        ProgramKind = Types::Symbol.enum(
          :e_snap,
          :snap,
          :tanf,
          :magi_medicaid,
          :medicaid
        )

        EvidenceCategory = Types::Symbol.enum(
          :income,
          :benefit,
          :deduction
        )

        EvidenceIncomeCategory = Types::Symbol.enum(
          :earned,
          :unearned
        )

        UsStateKind = Types::String.enum(
          'urn:openhbx:terms:v1:us_state#alabama',
          'urn:openhbx:terms:v1:us_state#alaska',
          'urn:openhbx:terms:v1:us_state#arizona',
          'urn:openhbx:terms:v1:us_state#arkansas',
          'urn:openhbx:terms:v1:us_state#california',
          'urn:openhbx:terms:v1:us_state#colorado',
          'urn:openhbx:terms:v1:us_state#connecticut',
          'urn:openhbx:terms:v1:us_state#delaware',
          'urn:openhbx:terms:v1:us_state#district_of_columbia',
          'urn:openhbx:terms:v1:us_state#florida',
          'urn:openhbx:terms:v1:us_state#georgia',
          'urn:openhbx:terms:v1:us_state#hawaii',
          'urn:openhbx:terms:v1:us_state#idaho',
          'urn:openhbx:terms:v1:us_state#illinois',
          'urn:openhbx:terms:v1:us_state#indiana',
          'urn:openhbx:terms:v1:us_state#iowa',
          'urn:openhbx:terms:v1:us_state#kansas',
          'urn:openhbx:terms:v1:us_state#kentucky',
          'urn:openhbx:terms:v1:us_state#louisiana',
          'urn:openhbx:terms:v1:us_state#maine',
          'urn:openhbx:terms:v1:us_state#maryland',
          'urn:openhbx:terms:v1:us_state#massachusetts',
          'urn:openhbx:terms:v1:us_state#michigan',
          'urn:openhbx:terms:v1:us_state#minnesota',
          'urn:openhbx:terms:v1:us_state#mississippi',
          'urn:openhbx:terms:v1:us_state#missouri',
          'urn:openhbx:terms:v1:us_state#montana',
          'urn:openhbx:terms:v1:us_state#nebraska',
          'urn:openhbx:terms:v1:us_state#nevada',
          'urn:openhbx:terms:v1:us_state#new_hampshire',
          'urn:openhbx:terms:v1:us_state#new_jersey',
          'urn:openhbx:terms:v1:us_state#new_mexico',
          'urn:openhbx:terms:v1:us_state#new_york',
          'urn:openhbx:terms:v1:us_state#north_carolina',
          'urn:openhbx:terms:v1:us_state#north_dakota',
          'urn:openhbx:terms:v1:us_state#ohio',
          'urn:openhbx:terms:v1:us_state#oklahoma',
          'urn:openhbx:terms:v1:us_state#oregon',
          'urn:openhbx:terms:v1:us_state#pennsylvania',
          'urn:openhbx:terms:v1:us_state#rhode_island',
          'urn:openhbx:terms:v1:us_state#south_carolina',
          'urn:openhbx:terms:v1:us_state#south_dakota',
          'urn:openhbx:terms:v1:us_state#tennessee',
          'urn:openhbx:terms:v1:us_state#texas',
          'urn:openhbx:terms:v1:us_state#utah',
          'urn:openhbx:terms:v1:us_state#vermont',
          'urn:openhbx:terms:v1:us_state#virginia',
          'urn:openhbx:terms:v1:us_state#washington',
          'urn:openhbx:terms:v1:us_state#west_virginia',
          'urn:openhbx:terms:v1:us_state#wisconsin',
          'urn:openhbx:terms:v1:us_state#wyoming'
        )

        PersonCandidateTypes = Types::Symbol.enum(:match_found, :created)

        PrimaryKeyKind    = 'urn:openhbx:hbx:dc0:resources:v1:dcas_journal:id'

        # E.164 Standard
        PhoneNumber       = Types::String.constrained(format: /^\+(?:[0-9] ?){6,14}[0-9]$/)
        Email             = Types::String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
        EmailOrString     = Email | String

        CoercibleDate     = Types.Constructor(::Date)     { |val| ::Date.strptime(val, '%Y%m%d') } | Date
        XmlSchemaDateTime = Types.Constructor(::DateTime) { |val| ::DateTime.xmlschema(val) } | DateTime
        CallableDate      = Types::Date.default { Date.today }
        CallableDateTime  = Types::DateTime.default { DateTime.now }

        HashOrNil         = Types::Hash | Types::Nil
        StringOrNil       = Types::String | Types::Nil

        RequiredString    = Types::Strict::String.constrained(min_size: 1)
        StrippedString    = Types::String.constructor(&:strip)
        SymbolOrString    = Types::Symbol | Types::String
        NilOrString       = Types::Nil | Types::String

        CoercedInteger        = Types::Coercible::Integer | Types::Coercible::Float.constructor(&:to_i)
        StrictSymbolizingHash = Types::Hash.schema({}).strict.with_key_transform(&:to_sym)

        Callable = Types.Interface(:call)

        Coercible::Bool = Types::Bool.constructor {|value| ActiveRecord::Type::Boolean.new.serialize(value)}

        # Represents the possible methods used to match a person
        # to an existing record, in order of preference
        PersonMatchStrategies = Types::String.enum(
          "primary_id",
          "alternate_id",
          "ssn_dob",
          "ssn",
          "first_last_dob"
        )

      end
      # rubocop:enable Metrics/ModuleLength, Layout/LineLength
    end
  end
end
