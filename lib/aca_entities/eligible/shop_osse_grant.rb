module AcaEntities
  module Eligible
    class ShopOsseGrant < Dry::Struct
      include Grant
      include Trackable

    end
  end
end
