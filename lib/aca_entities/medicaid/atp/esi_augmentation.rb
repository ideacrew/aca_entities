# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp ESI Augmentation
      class EsiAugmentation < Dry::Struct
        attribute :esi, Esi.optional.meta(omittable: true)
      end
    end
  end
end