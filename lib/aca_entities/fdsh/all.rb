# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module All
      # dependencies
      require_relative 'fdsh'

      # services
      require_relative 'ifsv'
      require_relative 'ridp'
      require_relative 'vlp'
      require_relative 'ssa'
    end
  end
end
