# frozen_string_literal: true

require 'dry/validation'
require 'dry/monads/result'

require 'dry/monads'
require 'dry/monads/do'
require 'dry-struct'

require 'aca_entities/version'
require 'aca_entities/error'

require 'aca_entities/libraries/core_library'
require 'aca_entities/libraries/aca_individual_market_library'
require 'aca_entities/libraries/insurance_policies_aca_individuals_library'
require 'aca_entities/libraries/fdsh_library'
require 'aca_entities/libraries/standard_library'

# require 'aca_entities/operations/operation'

# TODO: We want these to be selectively included at run time
require 'aca_entities/individual_market'
require 'aca_entities/shop_market'
require 'aca_entities/transform'

# TODO: Decide how to incorporate versioning? e.g. Iap::V3_0::Application
# TODO: Should we insure unique namespacing with prefix? e.g. AcaIap::Application

# AcaEntities is a portable domain model for sharing both Affordable Care Act (ACA)
# and general benefits management system information between services and applications.
#
# AcaEntities defines a Canonical Vocabulay (CV) for the benefits management domain along
# with schemas, validation contracts and transformations between other vocabularies
module AcaEntities
  def self.async_api_config_find_by_service_name(args)
    ::AcaEntities::AsyncApi::Operations::FindConfigsByServiceName.new.call(args)
  end
end
