# frozen_string_literal: true

require_relative 'files/read'
require_relative 'yaml/deserialize'
require_relative 'yaml/serialize'
require_relative 'encryption/encrypt'
require_relative 'encryption/decrypt'
require_relative 'mongoid/model_adapter'
require_relative 'mongoid/entity_adapter'

require_relative 'transforms/transform'
require_relative 'transforms/hash_functions'
require_relative 'transforms/transformer'

module AcaEntities
  # Operations are perform Functions on domain entities
  module Operations
  end
end
