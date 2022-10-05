module Eligibilities
  # Entity for Evidence
  class Evidence < Dry::Struct
    attribute :key, Types::Symbol.meta(omittable: false)
    attribute :title, Types::String.meta(omittable: false)
    attribute :description, Types::String.optional.meta(omittable: true)
    attribute :is_satisfied, Types::Bool.optional.meta(omittable: true)
    attribute :updated_by, Types::String.optional.meta(omittable: true)
    attribute :timestamps
  end
end
