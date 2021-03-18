module Google::Maps
  class CreateFeatureContract < ApplicationContract
    json do
      required(:type).filled(Maps::GeoJson::Types::FeatureKind)
      required(:geometry).hash do
        required(:type).filled(Maps::GeoJson::Types::GeometryKind)
        required(:coordinates).filled(:array)
      end
      required(:properties).filled(:hash)
    end
  end
end