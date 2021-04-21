# frozen_string_literal: true

# This file defines the maps
module AcaEntities
  module MagiMedicaid
    module Mitc
      module Transforms
        # Transform Keys and Values
        class EligibilityResponse < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'Determination Date', 'determination_date'

          namespace 'Applicants' do
            rewrap 'applicants', type: :array do
              map 'Person ID', 'person_id'
              map 'Medicaid Eligible', 'medicaid_eligible'

              namespace 'Medicaid Household' do
                rewrap 'medicaid_household', type: :hash do
                  map 'People', 'people'
                  map 'MAGI', 'magi'
                end
              end

              # map 'Determinations', 'determinations'
              map 'CHIP Ineligibility Reason', 'chip_ineligible_reason'

              namespace 'Determinations' do
                rewrap 'determinations', type: :hash do
                  namespace 'Residency' do
                    rewrap 'residency', type: :hash do
                      map 'Indicator', 'indicator'
                    end
                  end
                end
              end

              namespace 'cleanDets' do
                rewrap 'cleandets', type: :array do
                  map 'item', 'determination_kind'
                  map 'indicator', 'status'
                end
              end
            end
          end
        end
      end
    end
  end
end

