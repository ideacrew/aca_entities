module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp application application identificarion
      class ApplicationIdentity < Dry::Struct
        attribute :identification_id,        Types::String.optional.meta(omittable: false)
        attribute :identification_category,    Types::String.optional.meta(omittable: true)
        attribute :jurisdiction_iso_3166_code, Types::String.optional.meta(omittable: true)
      end
    end
  end
end