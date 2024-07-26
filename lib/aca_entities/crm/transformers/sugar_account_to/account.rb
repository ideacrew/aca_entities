# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Crm
    module Transformers
      module SugarAccountTo
        # Transforms a SugarCRM Account record to an Account entity suitable for AcaEntities.
        class Account
          include Dry::Monads[:do, :result]

          # Transforms SugarCRM account data to AcaEntities account format.
          #
          # @param params [Hash] The SugarCRM account data.
          # @return [Dry::Monads::Result::Success] When transformation succeeds.
          # @return [Dry::Monads::Result::Failure] When transformation fails.
          def call(params)
            result = yield transform(params)

            Success(result)
          end

          private

          # Performs the transformation of account data.
          #
          # @param params [Hash] The original SugarCRM account data.
          # @return [Dry::Monads::Result::Success<Hash>] The transformed account data.
          # @raise [StandardError] If any error occurs during the transformation process.
          def transform(params)
            Success(
              {
                hbxid_c: params[:hbxid_c],
                name: params[:name],
                email1: params[:email1],
                billing_address_street: params[:billing_address_street],
                billing_address_street2: params[:billing_address_street2],
                billing_address_street3: params[:billing_address_street3],
                billing_address_street4: params[:billing_address_street4],
                billing_address_city: params[:billing_address_city],
                billing_address_postalcode: params[:billing_address_postalcode],
                billing_address_state: params[:billing_address_state],
                phone_office: params[:phone_office],
                rawssn_c: params[:rawssn_c],
                raw_ssn_c: params[:raw_ssn_c], # Duplicate key, possibly an error.
                dob_c: params[:dob_c],
                contacts: transform_contacts(params[:contacts])
              }
            )
          rescue StandardError => e
            Failure("Unable to transform Sugar Account: #{e.message}")
          end

          # Transforms contact data associated with the SugarCRM account.
          #
          # @param sugar_contacts [Array<Hash>] The contact data from SugarCRM.
          # @return [Array<Hash>] The transformed contact data.
          def transform_contacts(sugar_contacts)
            sugar_contacts.map do |contact|
              {
                hbxid_c: contact[:hbxid_c],
                first_name: contact[:first_name],
                last_name: contact[:last_name],
                phone_mobile: contact[:phone_mobile],
                email1: contact[:email1],
                birthdate: contact[:birthdate],
                relationship_c: contact[:relationship_c]
              }
            end
          end
        end
      end
    end
  end
end
