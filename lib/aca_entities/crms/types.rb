# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Crm
    # rubocop:disable Layout/LineLength
    # custom crm types
    module Types
      send(:include, Dry.Types())
      include Dry::Logic

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

      # OSHA Types
      BinaryGenderKind    = Types::Coercible::Symbol.enum(:male, :female)

      ContactCaseKind     = Types::Coercible::Symbol.enum(:contact_exposure_case, :contact_index_case)
      WorkRelatedKind     = Types::Coercible::Symbol.enum(:contact_exposure_case, :contact_index_case)

      AccountCategoryKind = Types::Coercible::Symbol.enum(:my_organization, :contact_employer, :health_care_provider, :public_health_agency,
                                                          :testing_lab, :vendor, :other)
      ContactCategoryKind = Types::Coercible::Symbol.enum(:contact_representative, :contractor, :customer, :employee, :faculty, :guest,
                                                          :health_care_provider, :public_health_agency_reppresentative, :staff, :student, :other)

      AttestationResponseStates = Types::Coercible::Symbol.default(:no_response).enum(:no_response, :response_submitted, :response_not_required,
                                                                                      :absent_index_case_status, :absent_exposure_case_status, :absent_pto_status, :absent_remote_status, :absent_not_scheduled, :absent_other)
      ## CDC Types

      ConsentKind         = Types::Coercible::Symbol.enum(:text_message, :email_message, :electronic_notices, :lab_results)
      GenderKind          = Types::Coercible::Symbol.enum(:male, :female, :other, :unknown)

      YesNoUnknownKind    = Types::Coercible::Symbol.default(:no).enum(:yes, :no, :unknown, :refused)
      YesNoPartialKind    = Types::Coercible::Symbol.default(:no).enum(:yes, :no, :partial, :refused)
      YesNoKind           = Types::Coercible::Symbol.default(:no).enum(:yes, :no, :unanswered)
      AttestationKind     = Types::Coercible::Symbol.enum(:yes_no)
      GuideKind           = Types::Coercible::Symbol.enum(:internal, :external)

      InjuryOrIllnessKind = Types::Coercible::Symbol.default(:other_illness).enum(:injury, :skin_disorder, :respiratory_condition, :poisoning,
                                                                                  :hearing_loss, :other_illness)
      CaseOutcomeKind     = Types::Coercible::Symbol.enum(:death, :away_from_work, :job_transfer_or_restriction, :other_recordable_cases)

      EmploymentKind            = Types::Coercible::Symbol.enum(:employed, :unemployed, :unemployed_covid, :retired, :unable_to_work, :student,
                                                                :minor, :unknown)
      ContactSettingKind        = Types::Coercible::Symbol.enum(:home, :school, :dahy_care, :workplace, :place_of_worship, :shelter,
                                                                :health_medical_care, :travel_or_transit, :retail)
      HealthCareSettingKind     = Types::Coercible::Symbol.enum(:hospital, :ambulatory_care, :first_responder, :urgent_care, :long_term_care,
                                                                :hospice)
      PreExistingConditionKind  = Types::Coercible::Symbol.enum(:chronic_lung_disease, :diabetes, :severe_obesity, :cvd, :chronic_renal_disease,
                                                                :chronic_liver_disease, :immunocompromised, :pregnant)
      CongregateSettingKind     = Types::Coercible::Symbol.enum(:corrections, :dorm, :group_home, :multi_family_hh, :multi_generational_hh)
      LocationKind              = Types::Coercible::Symbol.enum(:congregate_settings, :correctional_facilities, :workplaces, :health_care,
                                                                :schools_and_childcare, :homeless_shelters)

      HighRiskOccupationKind    = Types::Coercible::Symbol.enum(:first_responder, :health_care_worker, :law_enforcement)

      SymptomKind               = Types::Coercible::Symbol.enum(:fever, :cough, :shortness_of_breath, :diarrhea, :headache,
                                                                :muscle_ache, :chills, :sore_throat, :vomiting, :abdominal_pain,
                                                                :loss_of_taste, :loss_of_smell, :nasal_congestion, :malaise, :fatigue)
      ## End CDC Types

      ResourceKind = Types::Coercible::Symbol.enum(:recording)

      InvestigationKind           = Types::Coercible::Symbol.enum(:clinical_monitoring, :contact_elicitation, :contact, :index_case)
      IndexCaseInvestigationKind  = Types::Coercible::Symbol.enum(:clinical_monitoring, :contact_elicitation, :index_case)
      ContactInvestigationKind    = Types::Coercible::Symbol.enum(:clinical_monitoring, :contact)

      UserAdminKind       = Types::Bool.default(false).enum(true, false)

      StatusKindKind      = Types::Coercible::Symbol.enum(:hospitalized, :self_quarantining, :isolating, :unknown)

      VitalKind           = Types::Coercible::Symbol.default(:living).enum(:living, :deceased)
      TestKind            = Types::Coercible::Symbol.enum(:virus, :antibody)

      ExposureKind        = Types::Coercible::Symbol.enum(:limited, :moderate, :significant)

      RaceKind            = Types::Coercible::Symbol.enum(:white, :asian, :antive_american, :black, :native_hawaiian, :other, :not_specified)
      EthnicityKind       = Types::Coercible::Symbol.enum(:white)

      ResidenceKind       = Types::Coercible::Symbol.enum(:single_family, :apartment, :group, :incarcerated, :homeless, :unknown)
      RelationshipKind    = Types::Coercible::Symbol.enum(:self, :spouse, :partner, :child, :parent, :grandparent, :grandchild,
                                                          :aunt, :uncle, :nephew, :niece, :friend, :other)

      # EmployeeStatusKind = Types::Coercible::Symbol.enum(:)

      AbsenceKind         = Types::Coercible::Symbol.enum(:pto, :covid_19_isolation, :covid_19_quarantine, :unknown)

      AccountAddressKind  = Types::Coercible::Symbol.default(:headquarters).enum(:billing, :shipping, :satellite, :headquarters)
      ContactAddressKind  = Types::Coercible::String.default("Business").enum("Billing", "Shipping", "Work", "Home", 'Business')

      Duration            = Types.Constructor(ActiveSupport::Duration) {|val| ActiveSupport::Duration.build(val) }

      # E.164 Standard
      PhoneNumber       = Types::String.constrained(format: /^\+(?:[0-9] ?){6,14}[0-9]$/)
      # PhoneNumber       = Types::String.constrained(format: /^\+\d{1,3}\s\d{1,14}(\s\d{1,13})$/)
      # PhoneNumber       = Types::String.constrained(format: /^\+\d{1,3}\s\d{1,14}(\s\d{1,13})?/)

      Email             = Types::String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      EmailOrString     = Types::Email | Types::String

      Serializers       = Types::String.default('yaml_serializer').enum('yaml_serializer', 'xml_serializer')
      Stores            = Types::String.default('file_store').enum('file_store')

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

      Callable = Types.Interface(:call)

    end
    # rubocop:enable Layout/LineLength
  end
end
