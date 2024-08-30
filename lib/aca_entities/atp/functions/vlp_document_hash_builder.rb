# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions

      # build VlpDocument hash so that transformer can deal with array values
      class VlpDocumentHashBuilder
        SUBJECT_MAP = {
          "NaturalizationCertificate" => "Naturalization Certificate",
          "CertificateOfCitizenship" => "Certificate of Citizenship",
          "DS2019" => "DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)",
          "I20" => "I-20 (Certificate of Eligibility for Nonimmigrant (F-1) Student Status)",
          "I327" => "I-327 (Reentry Permit)",
          "I551" => "I-551 (Permanent Resident Card)",
          "I571" => "I-571 (Refugee Travel Document)",
          "I766" => "I-766 (Employment Authorization Card)",
          "I94" => "I-94 (Arrival/Departure Record)",
          "I94InPassport" => "I-94 (Arrival/Departure Record) in Unexpired Foreign Passport",
          "MachineReadableVisa" => "Machine Readable Immigrant Visa (with Temporary I-551 Language)",
          "TemporaryI551Stamp" => "Temporary I-551 Stamp (on passport or I-94)",
          "UnexpiredForeignPassport" => "Unexpired Foreign Passport"
        }.freeze

        def call(document)
          vlp_document = update_subject(document)
          person_ids_hash = create_person_ids_hash(vlp_document)
          document_number_hash = create_document_number_hash(vlp_document)
          vlp_document = collect_document_fields(vlp_document)
          extracted_information_hash = person_ids_hash.merge!(document_number_hash)
          vlp_document.merge!(extracted_information_hash)
        end

        def update_subject(document)
          subject = document[:category_code]
          document[:category_code] = SUBJECT_MAP[subject] || subject
          document
        end

        def create_person_ids_hash(vlp_document)
          vlp_document[:document_person_ids]&.each_with_object({}) do |person_id, ids_hash|
            category_text_key = person_id[:identification_category_text]
            # may need to be revisited if category text contains hyphens or other special characters
            category_text_key = category_text_key&.split&.join("_")&.downcase&.to_sym
            ids_hash[category_text_key] = person_id[:identification_id]
          end
        end

        def create_document_number_hash(vlp_document)
          # may need to be revisited if category code contains hyphens or other special characters
          category_code_key = vlp_document[:category_code]&.split&.join("_")&.downcase&.to_sym
          # assuming only one document_number is sent and matches the document category code, may need to be revisited
          { category_code_key => vlp_document[:document_numbers]&.first&.dig(:identification_id) }
        end

        def collect_document_fields(vlp_document)
          # card number is only used by I-551 or I-766 documents.
          # it should also assign the document number to the citizenship number for Certificate of Citizenship documents.
          if ["I-551 (Permanent Resident Card)", "I-766 (Employment Authorization Card)"].include?(vlp_document[:category_code])
            vlp_document[:card_number] = vlp_document[:document_numbers]&.first&.dig(:identification_id).to_s
          elsif vlp_document[:category_code] == "Certificate of Citizenship"
            vlp_document[:citizenship_number] = vlp_document[:document_numbers]&.first&.dig(:identification_id).to_s
          elsif vlp_document[:category_code] == "Naturalization Certificate"
            vlp_document[:naturalization_number] = vlp_document[:document_numbers]&.first&.dig(:identification_id).to_s
          end

          # this handles whether the expiration date returned is a date inside a hash or null
          vlp_document[:expiration_date] =
            vlp_document[:expiration_date].is_a?(Hash) ? vlp_document[:expiration_date][:date] : vlp_document[:expiration_date]

          handle_document_person_ids(vlp_document)
          vlp_document
        end

        def handle_document_person_ids(vlp_document)
          document_person_ids = vlp_document[:document_person_ids]
          document_person_ids.each do |document_person_id|
            handle_identification_category(vlp_document, document_person_id)
          end
        end

        # this method handles the identification category text and maps it to the correct key in the vlp_document hash
        # Being flexible and extra cautious with case insensitive match for sevis id/ cert of citizenship/naturalization number
        # as we are unsure in which string case external system  will be sending the document category text.
        # The issue first occurred with the Sevis ID in DC client,
        # as sometimes DC sends it as Sevis ID, and other times as sevis id.
        def handle_identification_category(vlp_document, document_person_id)
          case document_person_id[:identification_category_text]
          when 'Alien Number'
            vlp_document[:alien_number] = document_person_id[:identification_id]
          when 'Passport Number'
            vlp_document[:passport_number] = document_person_id[:identification_id]
            vlp_document[:country_of_citizenship] = map_iso_to_country_names(document_person_id[:identification_jurisdiction])
          when 'I-94 Number'
            vlp_document[:i94_number] = document_person_id[:identification_id]
          when /sevis\s*id/i
            vlp_document[:sevis_id] = document_person_id[:identification_id]
          when 'Visa Number'
            vlp_document[:visa_number] = document_person_id[:identification_id]
          when /certificate\s*of\s*citizenship/i
            vlp_document[:citizenship_number] = document_person_id[:identification_id]
          when /naturalization\s*certificate\s*number/i
            vlp_document[:naturalization_number] = document_person_id[:identification_id]
          when /card\s*number/i
            vlp_document[:card_number] = document_person_id[:identification_id]
          end
        end

        def map_iso_to_country_names(country_of_citizenship)
          return nil unless country_of_citizenship.present?
          iso_country_name = IsoCountryCodes.find(country_of_citizenship).name
          if iso_countries.include?(iso_country_name)
            map_countries_to_iso[iso_country_name]
          else
            iso_country_name
          end
        end

        def iso_countries
          [
            "Bolivia (Plurinational State of)",
            "Brunei Darussalam",
            "Czechia",
            "Cote d'Ivoire",
            "Holy See",
            "Iran (Islamic Republic of)",
            "East Timor (Timor Timur)",
            "Korea (Democratic People's Republic of)",
            "Korea (Republic of)",
            "Lao People's Democratic Republic",
            "Macedonia (the former Yugoslav Republic of)",
            "Micronesia (Federated States of)",
            "Moldova (Republic of)",
            "Russian Federation",
            "Saint Vincent and the Grenadines",
            "Swaziland",
            "Syrian Arab Republic",
            "Tanzania, United Republic of",
            "Timor-Leste",
            "United Kingdom of Great Britain and Northern Ireland",
            "United States of America",
            "Venezuela (Bolivarian Republic of)"
          ]
        end

        # this is a list of countries that have different names in the ISO library than our vlp documents on the frontend
        def map_countries_to_iso
          {
            "Bolivia (Plurinational State of)" => "Bolivia",
            "Brunei Darussalam" => "Brunei",
            "Czechia" => "Czech Republic",
            "Côte d'Ivoire" => "Cote d'Ivoire",
            "Holy See" => "Vatican City",
            "Iran (Islamic Republic of)" => "Iran",
            "Korea (Democratic People's Republic of)" => "Korea, North",
            "Korea (Republic of)" => "Korea, South",
            "Lao People's Democratic Republic" => "Laos",
            "Macedonia (the former Yugoslav Republic of)" => "Macedonia",
            "Micronesia (Federated States of)" => "Micronesia",
            "Moldova (Republic of)" => "Moldova",
            "Russian Federation" => "Russia",
            "Saint Vincent and the Grenadines" => "Saint Vincent",
            "Swaziland" => "Eswatini",
            "Syrian Arab Republic" => "Syria",
            "Tanzania, United Republic of" => "Tanzania",
            "Timor-Leste" => "East Timor (Timor Timur)",
            "United Kingdom of Great Britain and Northern Ireland" => "United Kingdom",
            "United States of America" => "United States",
            "Venezuela (Bolivarian Republic of)" => "Venezuela"
          }
        end
      end
    end
  end
end
