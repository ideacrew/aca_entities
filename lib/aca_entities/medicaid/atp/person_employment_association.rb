# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonEmploymetAssociation
      class PersonEmploymentAssociation < Dry::Struct
        attribute :start_date, AssociationBeginDate.optional.meta(omittable: true)
        attribute :end_date, AssociationEndDate.optional.meta(omittable: true)
        attribute :employer, Employer.optional.meta(omittable: true)
      end
    end
  end
end