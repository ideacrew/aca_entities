module Maps
  class Label < Dry::Struct
    attribute :text_style,  TextStyle.meta(omittable: false)
  end
end
