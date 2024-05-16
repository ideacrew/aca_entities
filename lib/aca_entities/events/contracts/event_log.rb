module Events
  class EventLogContract < Contract
    # Use cases query examples:
    #   Everything an account_holder did for a time period
    #   Events an account_holder did with a specific Eligibility
    #   Events an account_holder did with a specific subject
    #   Time periods an account_holder was signed in

    params do
      required(:account).filled(:AcaEntities::Accounts::Session.prarms)
      # required(:account_holder).filled(:AcaEntities::People:Person.params)

      # Grouping of actions for an account_holder session
      required(:session).filled(AcaEntities::Accounts::Session.prarms)

      # Events result from commands/operations issued by the account_holder
      #   EventName, Timestamp, join to the subject model table
      #   Do events communicate change/correction
      required(:message).filled(AcaEntities::AsynApi.v2_0::Messages::Message.params)

      # Do we create a marketplace-to-data table mapping?
      # subject_model_table
      #   data table examples: benefit_sponsorship, family
      #   system table examples: session (sign_in, sign_out)

      required(:session_id).filled(:string)
      required(:session_id).filled(:string)
      required(:session_id).filled(:string)
      required(:session_id).filled(:string)
      required(:session_id).filled(:string)
      required(:session_id).filled(:string)
    end
  end

  class EventLog
  end

  subject
  audit_log_event
  subject_event

  enroll.benefit_sponsors.benefit_sponsorship.osse_renewal

  monitored_events = [
    {
      _monitored_event_type: :sessions_controller_event,
      _monitored_event_id: 'a1a1a1',
      event_name: 'enroll.controllers.sessions_controller.signed_in',
      subject_id: 'enroll/accounts/account/111',
      account_id: 'enroll/system',
      timestamp: '12:10'
    },
    {
      _monitored_event_type: :sessions_controller_event,
      _monitored_event_id: 'b2b2b2',
      event_name: 'enroll.controllers.sessions_controller.signed_out',
      subject_id: 'enroll/accounts/account/111',
      account_id: 'enroll/system',
      timestamp: '13:01'
    },
    {
      _monitored_event_type: :benefit_sponsorship_event,
      _monitored_event_id: 'c3c3c3',
      event_name: 'enroll.benefit_sponsors.benefit_sponsorship.eligibilities.osse_approved',
      subject_id: 'benefit_sponsors/benefit_sponsorship/555',
      account_id: 'enroll/accounts/account/111',
      timestamp: '12:05'
    },
    {
      _monitored_event_type: :benefit_sponsorship_event,
      _monitored_event_id: 'd4d4d4',
      event_name: 'enroll.benefit_sponsors.benefit_sponsorship.eligibilities.osse_renewed',
      subject_id: 'benefit_sponsors/benefit_sponsorship/555',
      account_id: 'enroll/system',
      timestamp: '13:01'
    },
    {
      _monitored_event_type: :person_event,
      _monitored_event_id: 'e5e5e5',
      event_name: 'enroll.person.eligibilities.osse_approved',
      subject_id: 'person/777',
      account_id: 'enroll/accounts/account/111',
      timestamp: '13:01'
    },
    {
      _monitored_event_type: :person_event,
      _monitored_event_id: 'e5e5e5',
      event_name: 'enroll.person.eligibilities.osse_renewed',
      subject_id: 'person/777',
      account_id: 'enroll/system',
      timestamp: '13:01'
    }
  ]

  sessions_controller_events = [
    {
      id: 'a1a1a1',
      event_name: :account_holder_signed_on,
      session_id: '123',
      subject_id: 'account/dan',
      timestamp: '12:00'
    }
  ]

  #   system_event # is_a event
  #   osse_shop_eligibility_event # is_a event
  #   osse_individual_eligibility_event # is_a event

  # eligibility has_many events
  # eligibility == price

  # Single table Inheritance Strategy
  class EventLog
    belongs_to :event, polymorphic: true

    # supplied by polymorphic
    field :_monitored_event_type, String # :benefit_sponsorship_event

    field :session_time_period, Range
    field :person, Hash
    field :subject_guid, Hash
    field :eligibility_name, String # OSSE_ELIGIBILTY

    field :account, Hash
    field :session, Hash
    field :message, Hash
  end

  #  subject = Subject.new(name: 'benefit_sponsorship')

  class Subject # Product (Model)
    has_one :event_log, as: event

    field :name, type: String # => :benefit_sponsorship
    has_many :eligiblities
  end

  class Event # Bundle
    has_one :event_log, as: event

    field :benefit_applications, Array
    field
  end

  class Event # Price
    # embedded_in , polymophic: true
  end

  class BenefitSponsorshipEligibilities
    has_one :event_log, as: event

    field :benefit_applications, Array
  end

  class FamilyEvent
    has_one :event_log, as: subject_event

    field :family_members, Array
  end
end
