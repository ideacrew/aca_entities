
module AcaEntities
  module GeneralAgencies
    class GeneralAgencyReference < Dry::Struct

      attribute :hbx_id,                            Types::String.meta(omittable: false)
      attribute :name,                              Types::String.meta(omittable: false)
      attribute :dba,                               Types::String.meta(omittable: false)
      attribute :display_name,                      Types::String.meta(omittable: false)
      attribute :fein,                              Types::String.meta(omittable: false)
      attribute :corporate_npn,                     Types::String.meta(omittable: false)
    end
  end
end