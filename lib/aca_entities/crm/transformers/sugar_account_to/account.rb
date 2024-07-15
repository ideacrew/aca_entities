# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Crm
    module Transformers
      module SugarAccountTo
        # Transforms a Sugar Account to an Account entity
        class Account
          include Dry::Monads[:do, :result]

          def call(params)
            result = yield transform(params)

            Success(result)
          end

          private

          def transform(params)
            Success(
              {
                hbxid_c: params[:hbxid_c],
                name: params[:name],
                email1: params[:email1],
                billing_address_street: params[:billing_address_street],
                billing_address_city: params[:billing_address_city],
                billing_address_postalcode: params[:billing_address_postalcode],
                billing_address_state: params[:billing_address_state],
                phone_office: params[:phone_office],
                # Incoming/inbound sugar 'raw_ssn_c' might have a different format than the expected format.
                raw_ssn_c: params[:raw_ssn_c],
                dob_c: params[:dob_c],
                contacts: transform_contacts(params[:contacts])
              }
            )
          rescue StandardError => e
            Failure("Unable to transform Sugar Account: #{e.message}")
          end

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
