# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Include XML element and type definitions.
            class InsuranceEndDate
              include HappyMapper
              register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

              tag 'InsuranceEndDate'
              namespace 'nc'

              element :date, Date, tag: "Date", namespace: "nc"

              def self.domain_to_mapper(start_date)
                mapper = self.new
                mapper.date = start_date.strftime

                mapper
              end
            end
          end
        end
      end
    end
  end
end
