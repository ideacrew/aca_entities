# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class Income
              include HappyMapper
              register_namespace 'hcore', 'http://hix.cms.gov/0.1/hix-core'

              tag 'Household'
              namespace 'hcore'

              element :IncomeAmount, Float, tag: 'IncomeAmount', namespace: "hcore"

              def self.domain_to_mapper(income_response)
                mapper = self.new
                mapper.IncomeAmount = income_response.IncomeAmount
                mapper
              end
            end
          end
        end
      end
    end
  end
end