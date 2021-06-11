# frozen_string_literal: true

require 'dry/validation'
require 'dry/monads/result'

require 'dry/monads'
require 'dry/monads/do'
require 'dry-struct'

require 'aca_entities/version'
require 'aca_entities/error'

require 'aca_entities/libraries/aca_individual_market_library'
require 'aca_entities/libraries/core_library'
require 'aca_entities/libraries/fdsh_library'

# require 'aca_entities/operations/operation'

# TODO: We want these to be selectively included at run time
require 'aca_entities/individual_market'
require 'aca_entities/shop_market'
require 'aca_entities/transform'
require 'aca_entities/functions/age_on'
require 'aca_entities/functions/primary_applicant_builder'

# TODO: Decide how to incorporate versioning? e.g. Iap::V3_0::Application
# TODO: Should we insure unique namespacing with prefix? e.g. AcaIap::Application

# AcaEntities provides a shared interface for the serialization and deserialization
# of shared ACA entities across applications.
module AcaEntities
end
