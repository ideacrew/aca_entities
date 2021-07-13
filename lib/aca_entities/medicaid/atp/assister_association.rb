# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp assister association
      class AssisterAssociation < Dry::Struct
        attribute :begin_date,         AssociationBeginDate.optional.meta(omittable: true)
        attribute :end_date,           AssociationEndDate.optional.meta(omittable: true)
        attribute :assister_reference, InsuranceApplicationAssisterReference.optional.meta(omittable: true)
      end
    end
  end
end