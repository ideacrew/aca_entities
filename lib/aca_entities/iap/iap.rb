# frozen_string_literal: true

require 'dry-types'
require_relative 'types'
require_relative 'application'
require_relative 'employer'
require_relative 'family'
require_relative 'workflow'
# require_relative 'benefit'
# require_relative 'deduction'
require_relative 'eligibility_determination'
require_relative 'iap_questionnaire'
# require_relative 'income'
require_relative 'relationship'
require_relative 'verification'
require_relative 'applicant'
require_relative 'contracts/application_contract'
require_relative 'contracts/benefit_contract'

# Behaviour for Individual Applications.
module Iap; end
