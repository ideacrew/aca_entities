# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions
      # build immigration documents
      class ImmigrationDocumentBuilder

        def call(cache) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
          @vlp_document = cache.resolve('vlp_document').item
          return [] unless @vlp_document

          case @vlp_document[:subject]
          when 'I-327 (Reentry Permit)'
            doc = i327_doc
          when 'I-551 (Permanent Resident Card)'
            doc = i551_doc
          when 'I-571 (Refugee Travel Document)'
            doc = i571_doc
          when 'I-766 (Employment Authorization Card)'
            doc = i766_doc
          when 'Certificate of Citizenship'
            doc = citizenship_doc
          when 'Naturalization Certificate'
            doc = naturalization_doc
          when 'Machine Readable Immigrant Visa (with Temporary I-551 Language)'
            doc = machine_readable_visa_doc
          when 'Temporary I-551 Stamp (on passport or I-94)'
            doc = i557_stamp_doc
          when 'I-94 (Arrival/Departure Record)'
            doc = i94_doc
          when 'I-94 (Arrival/Departure Record) in Unexpired Foreign Passport'
            doc = i94_in_passport_doc
          when 'Unexpired Foreign Passport'
            doc = foreign_passport_doc
          when 'I-20 (Certificate of Eligibility for Nonimmigrant (F-1) Student Status)'
            doc = i20_doc
          when 'DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)'
            doc = ds2019_doc
          when 'Other (with alien number)'
            # Uncertain mapping to XML
          when 'Other (with I-94 number)'
            # Uncertain mapping to XML
          end

          [doc]
        end

        def i327_doc
          {
            category_code: 'I327',
            expiration_date: expiration_date,
            document_numbers: [alien_number]
          }
        end

        def i551_doc
          {
            category_code: 'I551',
            expiration_date: expiration_date,
            document_numbers: [alien_number, card_number]
          }
        end

        def i571_doc
          {
            category_code: 'I571',
            expiration_date: expiration_date,
            document_numbers: [alien_number]
          }
        end

        def i766_doc
          {
            category_code: 'I766',
            expiration_date: expiration_date,
            document_numbers: [alien_number, card_number]
          }
        end

        def citizenship_doc
          {
            category_code: 'CertificateOfCitizenship',
            expiration_date: expiration_date,
            document_numbers: [citizenship_number, alien_number]
          }
        end

        def naturalization_doc
          {
            category_code: 'NaturalizationCertificate',
            expiration_date: expiration_date,
            document_numbers: [naturalization_number]
          }
        end

        def machine_readable_visa_doc
          {
            category_code: 'MachineReadableVisa',
            expiration_date: expiration_date,
            document_numbers: [alien_number, passport_number, visa_number]
          }
        end

        def i557_stamp_doc
          {
            category_code: 'TemporaryI551Stamp',
            expiration_date: expiration_date,
            document_numbers: [alien_number, passport_number]
          }
        end

        def i94_doc
          {
            category_code: 'I94',
            expiration_date: expiration_date,
            document_numbers: [i94_number, sevis_id]
          }
        end

        def i94_in_passport_doc
          {
            category_code: 'I94InPassport',
            expiration_date: expiration_date,
            document_numbers: [i94_number, visa_number, sevis_id, passport_number]
          }
        end

        def foreign_passport_doc
          {
            category_code: 'UnexpiredForeignPassport',
            expiration_date: expiration_date,
            document_numbers: [passport_number, i94_number, sevis_id]
          }
        end

        def i20_doc
          {
            category_code: 'I20',
            expiration_date: expiration_date,
            document_numbers: [i94_number, sevis_id, passport_number]
          }
        end

        def ds2019_doc
          {
            category_code: 'DS2019',
            expiration_date: expiration_date,
            document_numbers: [i94_number, sevis_id, passport_number]
          }
        end

        def alien_number
          return unless @vlp_document[:alien_number]
          {
            :identification_id => @vlp_document[:alien_number],
            :identification_category_text => "Alien Number"
          }
        end

        def i94_number
          return unless @vlp_document[:i94_number]
          {
            :identification_id => @vlp_document[:i94_number],
            :identification_category_text => "I-94 Number"
          }
        end

        def visa_number
          return unless @vlp_document[:visa_number]
          {
            :identification_id => @vlp_document[:visa_number],
            :identification_category_text => "Visa Number"
          }
        end

        def passport_number
          return unless @vlp_document[:passport_number]
          {
            :identification_id => @vlp_document[:passport_number],
            :identification_category_text => "Passport Number",
            :identification_jurisdiction => @vlp_document[:country_of_citizenship]
          }
        end

        def sevis_id
          return unless @vlp_document[:sevis_id]
          {
            :identification_id => @vlp_document[:sevis_id],
            :identification_category_text => "SEVIS ID"
          }
        end

        def naturalization_number
          return unless @vlp_document[:naturalization_number]
          {
            :identification_id => @vlp_document[:naturalization_number],
            :identification_category_text => "Naturalization Number"
          }
        end

        def receipt_number
          return unless @vlp_document[:receipt_number]
          {
            :identification_id => @vlp_document[:receipt_number],
            :identification_category_text => "Receipt Number"
          }
        end

        def citizenship_number
          return unless @vlp_document[:citizenship_number]
          {
            :identification_id => @vlp_document[:citizenship_number],
            :identification_category_text => "Citizenship Number"
          }
        end

        def card_number
          return unless @vlp_document[:card_number]
          {
            :identification_id => @vlp_document[:card_number],
            :identification_category_text => "Card Number"
          }
        end

        def expiration_date
          exp_date = @vlp_document[:expiration_date]
          return unless exp_date

          parsed_exp_date = exp_date.respond_to?(:strftime) ? Date.strptime(exp_date, "%m/%d/%Y") : Date.parse(exp_date)
          { date: parsed_exp_date }
        rescue ArgumentError => _e
          # exclude expiration date if unparsable
          nil
        end
      end
    end
  end
end
