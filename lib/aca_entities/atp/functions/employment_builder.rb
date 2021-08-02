# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions
      # build application and applicants
      class EmploymentBuilder
        def call(cache)
          @memoized_data = cache

          applicants_hash = @memoized_data.resolve('family.magi_medicaid_applications.applicants').item
          member_id = @memoized_data.find(/family.family_members.(\w+)$/).map(&:item).last
          incomes = applicants_hash[member_id.to_sym][:incomes]
          result = incomes.each_with_object([]) do |income, collect|
            next unless income[:kind] == 'wages_and_salaries'

            atp_employment = {:begin_date=>nil,
                                :end_date=>nil,
                                :employer=>
                                 {:employer_id=> income[:employer][:employer_id],
                                  :category_text=> income[:employer][:employer_name],
                                  :organization_primary_contact_information=>
                                   {:email_id=>nil
                                    # :mailing_address=>
                                    #  {:address=>
                                    #    {:location_street=>{:street_full_text=> income[:employer_address][:address_1],
                                    #     :address_secondary_unit_text=> income[:employer_address][:address_2],
                                    #     :location_city_name=> income[:employer_address][:city],
                                    #     :location_county_name=> income[:employer_address][:county],
                                    #     :location_county_code=> nil,
                                    #     :location_state_us_postal_service_code=> income[:employer_address][:state],
                                    #     :location_postal_code=> income[:employer_address][:zip]}},
                                    # :telephone_number=> income[:employer_phone]}
                                    }}}
            collect << atp_employment
          end
          
          result
        end
      end
    end
  end
end
