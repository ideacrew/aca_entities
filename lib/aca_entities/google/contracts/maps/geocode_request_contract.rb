module Google::Maps

  class GeocodeRequestContract < ApplicationContract

    params do
      required(:key).filled(:string)
      required(:address).filled(:string)
    end

  end
end
