# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Db
        # Adding seed for Identifiers
        module Seeds

          IdentifierKind = [
            {
              key: :case,
              namespace: 'curam',
              label: 'Curam Case Id',
              description: ''
            }
          ].freeze

          IdentifierKind.each do |kind|
            AcaEntities::Identifiers::IdentifierKinds << kind unless AcaEntities::Identifiers::IdentifierKinds.map {|d| d[:key]}.include?(kind[:key])
          end
        end
      end
    end
  end
end






