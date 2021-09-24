# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Health_Benefit_Coverage/Income via Employer
    # Entity for Employer.
    class Employer < Dry::Struct
      attribute :employer_name,  Types::String.optional.meta(omittable: true)
      attribute :employer_id,    Types::String.optional.meta(omittable: true)
      attribute :employer_address, AcaEntities::Locations::Address.optional.meta(omittable: true)
      attribute :employer_phone, AcaEntities::Contacts::PhoneContact.optional.meta(omittable: true)
    end
  end
end
