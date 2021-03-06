# frozen_string_literal: true

module AcaEntities
  module Maps
    # ActiveRecord selction criteria or SQL command applied to source
    class Filter < Dry::Struct
      attribute :critera, Types::String
    end
  end
end
