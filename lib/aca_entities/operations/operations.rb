# frozen_string_literal: true

require_relative 'operation'
require_relative 'composite_operation'
require_relative 'files/read'
require_relative 'yaml/deserialize'
require_relative 'yaml/serialize'
require_relative 'encryption/encrypt'
require_relative 'encryption/decrypt'
require_relative 'mongoid/model_adapter'
require_relative 'mongoid/entity_adapter'

module AcaEntities
  # The Operations mixin applies both the Command and Composition development patterns
  # to build complex process flows that may be organized into tree structures
  module Operations
  end
end
