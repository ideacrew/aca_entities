# frozen_string_literal: true

module Ehs::Verifications
  class Verification < Dry::Struct

    # Person Verification
    attribute :lawful_presence,         LawfulPresence.meta(omittable: false)
    attribute :residency,               Residency.meta(omittable: false)

    # Income Verification
    # attribute :ssa_income_verification, SsaIncomeVerification.optional.meta(omittable: true)
  end
end
