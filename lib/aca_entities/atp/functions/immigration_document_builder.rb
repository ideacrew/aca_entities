# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions
      # build immigration documents
      class ImmigrationDocumentBuilder # rubocop:disable Metrics/ClassLength

        def call(cache) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
          # return if applicant is us_citizen (not naturalized)
          @vlp_document = cache.resolve('vlp_document').item
          @document_person_ids = []
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

        # Document hash methods
        def i327_doc
          @document_person_ids << alien_number if alien_number
          {
            category_code: 'I327',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def i551_doc
          @document_person_ids << alien_number if alien_number
          @document_person_ids << card_number if card_number
          {
            category_code: 'I551',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def i571_doc
          @document_person_ids << alien_number if alien_number
          {
            category_code: 'I571',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def i766_doc
          @document_person_ids << alien_number if alien_number
          @document_person_ids << card_number if card_number
          {
            category_code: 'I766',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def citizenship_doc
          @document_person_ids << citizenship_number if citizenship_number
          @document_person_ids << alien_number if alien_number
          {
            category_code: 'CertificateOfCitizenship',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def naturalization_doc
          @document_person_ids << naturalization_number if naturalization_number
          @document_person_ids << alien_number if alien_number
          {
            category_code: 'NaturalizationCertificate',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def machine_readable_visa_doc
          @document_person_ids << alien_number if alien_number
          @document_person_ids << passport_number if passport_number
          @document_person_ids << visa_number if visa_number
          {
            category_code: 'MachineReadableVisa',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def i557_stamp_doc
          @document_person_ids << alien_number if alien_number
          @document_person_ids << passport_number if passport_number
          {
            category_code: 'TemporaryI551Stamp',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def i94_doc
          @document_person_ids << i94_number if i94_number
          @document_person_ids << sevis_id if sevis_id
          {
            category_code: 'I94',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def i94_in_passport_doc
          @document_person_ids << i94_number if i94_number
          @document_person_ids << visa_number if visa_number
          @document_person_ids << sevis_id if sevis_id
          @document_person_ids << passport_number if passport_number
          {
            category_code: 'I94InPassport',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def foreign_passport_doc
          @document_person_ids << passport_number if passport_number
          @document_person_ids << i94_number if i94_number
          @document_person_ids << sevis_id if sevis_id
          {
            category_code: 'UnexpiredForeignPassport',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def i20_doc
          @document_person_ids << i94_number if i94_number
          @document_person_ids << sevis_id if sevis_id
          @document_person_ids << passport_number if passport_number
          {
            category_code: 'I20',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        def ds2019_doc
          @document_person_ids << i94_number if i94_number
          @document_person_ids << sevis_id if sevis_id
          @document_person_ids << passport_number if passport_number
          {
            category_code: 'DS2019',
            expiration_date: expiration_date,
            document_person_ids: @document_person_ids
          }
        end

        # Document number hash methods
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
            :identification_category_text => "Sevis ID"
          }
        end

        def naturalization_number
          return unless @vlp_document[:naturalization_number]
          {
            :identification_id => @vlp_document[:naturalization_number],
            :identification_category_text => "Naturalization Certificate Number"
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
            :identification_category_text => "Certificate Of Citizenship"
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
