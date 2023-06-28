module AcaEntities
  module Eligible
    class IvlOsseGrant < Dry::Struct
      include Grant
      include History

    end
  end
end
