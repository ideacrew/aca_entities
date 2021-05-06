# frozen_string_literal: true

module AcaEntities
  module Crms
    module SugarCrm
      module Locations
        # contract for sugar_crm Address
        class AddressContract < ApplicationContract
          params do
            optional(:street).maybe(:string)
            optional(:street_2).maybe(:string)
            optional(:street_3).maybe(:string)
            optional(:street_4).maybe(:string)
            optional(:city).maybe(:string)
            optional(:state).maybe(:string)
            optional(:postalcode).maybe(:string)
            optional(:country).maybe(:string)
          end
        end
      end
    end
  end
end