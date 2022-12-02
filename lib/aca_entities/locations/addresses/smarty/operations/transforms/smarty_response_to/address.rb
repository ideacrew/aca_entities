# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Locations
    module Smarty
      module Operations
        module Transforms
          module SmartyResponseTo
            # Transform a Smarty response payload to CV address
            class Address
              include Dry::Monads[:result, :do]

              # @param [Hash] params the Smarty API response payload to transform
              # @return [Dry::Monads::Success] CV Address
              # @return [Dry::Monads::Failure] Response transform errors
              def call(params)
                values = yield validate(params)
                address = yield transform(values)

                Success(address)
              end

              private

              def validate(params)
                result = AcaEntities::Locations::Smarty::Contracts::ResponseContract.new.call(params)
                result.errors.empty? ? Success(result) : Failure(result)
              end

              def transform(values)
                address =
                  AcaEntities::Locations::Addresses::StreetAddress.new.tap do |addr|
                    addr.address_1 = values[:delivery_line_1]
                    addr.address_2 =
                      [values[:components][:secondary_designator], values[:components][:secondary_number]].join(' ')
                    addr.city_name = values[:components][:city_name]
                    addr.state_name = values[:components][:state_abbrevation]
                    addr.zip_code = values[:components][:zipcode]
                    addr.zip_plus_four_code = values[:components][:zipcode]
                    addr.county_name = values[:metadata][:county]
                    addr.county_fips_code = values[:metadata][:county_fips]
                    addr.validation_status = {
                      authority: 'smarty_streets',
                      payload: values,
                      validated_at: DateTime.now
                    }.to_json
                  end

                Success(address)
              end
            end
          end
        end
      end
    end
  end
end
