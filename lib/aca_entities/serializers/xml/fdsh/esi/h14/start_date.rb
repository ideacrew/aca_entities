# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Include XML element and type definitions.
            class StartDate
              include HappyMapper
              register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

              tag 'StartDate'
              namespace 'nc'

              element :Date, Date, tag: "Date", namespace: "nc"

              def self.domain_to_mapper(start_date)
                mapper = self.new
                mapper.Date = start_date

                mapper
              end
            end
          end
        end
      end
    end
  end
end
