# frozen_string_literal: true

require 'dry/validation'
require 'dry/monads/result'

require 'dry/monads'
require 'dry/monads/do'
require 'dry-struct'

require 'aca_entities/types'
require 'aca_entities/version'
require 'aca_entities/error'

require 'aca_entities/operations/operation'

require 'aca_entities/address'

# TODO: We want these to be selectively included at run time
require 'aca_entities/individual_market'
require 'aca_entities/shop_market'

# TODO: Decide how to incorporate versioning? e.g. Iap::V3_0::Application
# TODO: Should we insure unique namespacing with prefix? e.g. AcaIap::Application

# AcaEntities provides a shared interface for the serialization and deserialization
# of shared ACA entities across applications.
module AcaEntities
end
