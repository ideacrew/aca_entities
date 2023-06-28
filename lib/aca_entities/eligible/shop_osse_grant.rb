module AcaEntities
  module Eligible
    class ShopOsseGrant < Dry::Struct
      include Grant
      include History

    end
  end
end
