# frozen_string_literal: true

module Locations
  class Location < Dry::Struct

    attribute :outbreak_history,  Types::Array.of(Outbreaks::OutbreakHistory).meta(omittable: true)
    
  end
end