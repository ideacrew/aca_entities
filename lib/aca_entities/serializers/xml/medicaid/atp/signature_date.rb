# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A signature on a physical or electronic document.
          class SignatureDate
            include HappyMapper

            tag 'SignatureDate'
            namespace 'hix-core'

            element :date, Date, tag: 'Date', namespace: 'nc'

            def self.domain_to_mapper(signature_date)
              mapper = self.new
              mapper.date = signature_date.date
              mapper
            end

            def to_hash
              {
                date: date
              }
            end
          end
        end
      end
    end
  end
end