# frozen_string_literal: true

# require 'smartystreets_ruby_sdk/static_credentials'
# require 'smartystreets_ruby_sdk/client_builder'
# require 'smartystreets_ruby_sdk/us_street/lookup'

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Locations
    module Smarty
      module Operations
        # Validate a US Street Address using SmartyStreets Ruby SDK
        class VerifyAddress
          include Dry::Monads[:result, :do]

          # @param [Hash] params the params to access the SmartyStreets service and
          # the address to be validated
          # @options params [Hash] credentials SmartyStreet authentication ID and token
          # @options params [Hash] address US street address to be validated
          # @return [String] File contents wrapped in Dry::Monads::Result
          def call(params)
            values = yield validate(params)
            client = yield build_client
            lookup = yield build_lookup(values)
            result = yield validate_address(client, lookup)

            Success(result)
          end

          private

          def validate(params)
            # Locations::Smarty::Contracts::AddressContract.new.call(params)
            result = AcaEntities::Locations::Smarty::Contracts::LookupContract.new.call(params[:credentials])
            result.errors.empty? ? Success(result) : Failure(result)
          end

          def build_client
            credentials = { auth_id: 'ae66ac42-64a2-b3fe-19bb-454a659582aa', auth_token: '0TnIsQKZ3UFAqvDbmJxT' }

            # Store secret keys in environment variables
            #   auth_id = ENV['SMARTY_AUTH_ID']
            #   auth_token = ENV['SMARTY_AUTH_TOKEN']
            auth_id = credentials[:auth_id]
            auth_token = credentials[:auth_token]

            credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)

            # The appropriate license values to be used for your subscriptions
            # can be found on the Subscriptions page of the account dashboard.
            # https://www.smartystreets.com/docs/cloud/licensing

            Success(
              # SmartyStreets::ClientBuilder.new(credentials).with_licenses(['us-core-cloud']).build_us_street_api_client
              SmartyStreets::ClientBuilder.new(credentials).build_us_street_api_client
            )
          end

          # Documentation for SmartyStreets input fields can be found at:
          # https://smartystreets.com/docs/cloud/us-street-api
          def build_lookup(values)
            lookup =
              SmartyStreets::USStreet::Lookup.new.tap do |lu|
                lu.input_id = values[:input_id]
                lu.addressee = values[:addressee]
                lu.street = values[:street]
                lu.street2 = values[:street2]
                lu.secondary = values[:secondary]
                lu.urbanization = values[:urbanization]
                lu.city = values[:city]
                lu.state = values[:state]
                lu.zipcode = values[:zipcode]
                lu.candidates = values[:candidates]
                lu.match = values[:match]
              end
            Success(lookup)
          end

          # Use client to request address verification on Lookup instance
          # @param [SmartyStreets::Client] client <description>
          # @param [SmartyStreets::USStreet::Lookup] lookup <description>
          # @return [Array<SmartyStreets::USStreet::Candidate>] A list of matching addresses
          # @return [Array] empty array when no matches are found
          def validate_address(client, lookup)
            begin
              client.send_lookup(lookup)
            rescue SmartyStreets::SmartyError => e
              Failure(e)
            end

            result = lookup.result
            result.present? ? Success(result) : Failure("address invalid: #{lookup.inspect}")
          end
        end
      end
    end
  end
end
