module Eligibilities
  class Eligibility
    field :subject, type: Eligibilities::Subject
    field :status # is_eligibile?
    field :evidences, type: Eligibilities::Evidence
    field :grants, type: Eligibilities::Evidence
    field :start_on
    field :end_on
  end

  class Grant
    field :title
    field :description
    field :key
    field :value, Eligibilities::Value
    field :start_on, Types::Date.meta(omittable: false)
    field :end_on, Types::Date.meta(omittable: false)    field :start_on
  end

  class Subject
    field :title
    field :description
    field :key
    field :klass # GlobalID
  end

  class Eligibilities::Value
    field :title
    field :description
    field :key
  end

  class BenefitSponsorshipOssePolicy < Eligibilities::Value
    field :value # reference to OSSE policy/rules in rules engine
  end

end

