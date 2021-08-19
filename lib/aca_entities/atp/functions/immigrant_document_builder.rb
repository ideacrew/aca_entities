# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions
      # build immigration documents
      class ImmigrantDocumentBuilder

        def call(cache) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
          @memoized_data = cache
          vlp_document = @memoized_data.resolve('vlp_document').item
          return [] unless vlp_document

          @doc = {}

          # TODO: add document_person_ids based on applicant's identity???
          if vlp_document[:alien_number]
            @alien_number = {
              :identification_id => vlp_document[:alien_number],
              :identification_category_text => "Alien Number"
            }
          end

          if vlp_document[:i94_number]
            @i94_number = {
              :identification_id => vlp_document[:i94_number],
              :identification_category_text => "I-94 Number"
            }
          end

          if vlp_document[:visa_number]
            @visa_number = {
              :identification_id => vlp_document[:visa_number],
              :identification_category_text => "Visa Number"
            }
          end

          if vlp_document[:passport_number]
            @passport_number = {
              :identification_id => vlp_document[:passport_number],
              :identification_category_text => "Passport Number",
              :identification_jurisdiction => vlp_document[:country_of_citizenship]
            }
          end

          if vlp_document[:sevis_id]
            @sevis_id = {
              :identification_id => vlp_document[:sevis_id],
              :identification_category_text => "SEVIS ID"
            }
          end

          if vlp_document[:naturalization_number]
            @naturalization_number = {
              :identification_id => vlp_document[:naturalization_number],
              :identification_category_text => "Naturalization Number"
            }
          end

          if vlp_document[:receipt_number]
            @receipt_number = {
              :identification_id => vlp_document[:receipt_number],
              :identification_category_text => "Receipt Number"
            }
          end

          if vlp_document[:citizenship_number]
            @citizenship_number = {
              :identification_id => vlp_document[:citizenship_number],
              :identification_category_text => "Citizenship Number"
            }
          end

          if vlp_document[:card_number]
            @card_number = {
              :identification_id => vlp_document[:card_number],
              :identification_category_text => "Card Number"
            }
          end

          case vlp_document[:subject]
          when 'I-327 (Reentry Permit)'
            @doc = {
              category_code: 'I327',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@alien_number]
            }
          when 'I-551 (Permanent Resident Card)'
            @doc = {
              category_code: 'I551',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@alien_number, @card_number]
            }
          when 'I-571 (Refugee Travel Document)'
            @doc = {
              category_code: 'I571',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@alien_number]
            }
          when 'I-766 (Employment Authorization Card)'
            @doc = {
              category_code: 'I766',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@alien_number, @card_number]
            }
          when 'Certificate of Citizenship'
            @doc = {
              category_code: 'CertificateOfCitizenship',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@citizenship_number, @alien_number]
            }
          when 'Naturalization Certificate'
            @doc = {
              category_code: 'NaturalizationCertificate',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@naturalization_number]
            }
          when 'Machine Readable Immigrant Visa (with Temporary I-551 Language)'
            @doc = {
              category_code: 'MachineReadableVisa',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@alien_number, @passport_number, @visa_number]
            }
          when 'Temporary I-551 Stamp (on passport or I-94)'
            @doc = {
              category_code: 'TemporaryI551Stamp',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@alien_number, @passport_number]
            }
          when 'I-94 (Arrival/Departure Record)'
            @doc = {
              category_code: 'I94',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@i94_number, @sevis_id]
            }
          when 'I-94 (Arrival/Departure Record) in Unexpired Foreign Passport'
            @doc = {
              category_code: 'I94InPassport',
              document_numbers: [@i94_number, @visa_number, @sevis_id, @passport_number]
            }
          when 'Unexpired Foreign Passport'
            @doc = {
              category_code: 'UnexpiredForeignPassport',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@passport_number, @i94_number, @sevis_id]
            }
          when 'I-20 (Certificate of Eligibility for Nonimmigrant (F-1) Student Status)'
            @doc = {
              category_code: 'I20',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@i94_number, @sevis_id, @passport_number]
            }
          when 'DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)'
            @doc = {
              category_code: 'DS2019',
              expiration_date: vlp_document[:expiration_date],
              document_numbers: [@i94_number, @sevis_id, @passport_number]
            }
          end

          [@doc]
        end
      end
    end
  end
end
