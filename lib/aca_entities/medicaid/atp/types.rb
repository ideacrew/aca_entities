# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Shared type definitions for Account Transfer Protocol.
      module Types
        include Dry::Types()

        TransferHeaderRecipientCode = String.enum("Exchange", "MedicaidCHIP")
        EligibilityBasisStatusCode = String.enum("Complete", "Pending", "NotApplicable", "Inconsistent")
        ContactPreferenceCode = String.enum("TextMessage", "Email", "Mail")
        FfeVerificationCode = String.enum("Y", "N", "I", "P")
        InformationExchangeSystemCategoryCode = String.enum("Exchange", "MedicaidAgency", "CHIPAgency")
        TaxReturnFilingStatusCode = String.enum("0", "1", "2", "3", "4", "5", "6", "7")
        ReferralActivityReasonCode = String.enum("FullDetermination", "WaitingPeriodException", "GapFilling")
        IncomeCategoryCode = String.enum(
          "CapitalGains",
          "Interest",
          "Wages",
          "RentalOrRoyalty",
          "FarmingOrFishing",
          "Winnings",
          "Alimony",
          "SocialSecurity",
          "Unemployment",
          "Retirement",
          "CanceledDebt",
          "CourtAward",
          "JuryDuty",
          "SelfEmployment",
          "CashSupport",
          "Scholarship",
          "Unspecified",
          "Pension"
        )
        ImmigrationDocumentCategoryCode = String.enum(
          "AmericanSamoan",
          "CertificateOfCitizenship",
          "CubanHaitianEntrant",
          "DS2019",
          "I20",
          "I327",
          "I551",
          "I571",
          "I766",
          "I797",
          "I94",
          "I94InPassport",
          "MachineReadableVisa",
          "Native",
          "NaturalizationCertificate",
          "ORRCertification",
          "ORREligibilityLetter",
          "StayOfRemoval",
          "WithholdingOfRemoval",
          "TemporaryI551Stamp",
          "UnexpiredForeignPassport"
        )
        FrequencyCode = String.enum(
          "Weekly",
          "Monthly",
          "Annually",
          "BiWeekly",
          "Quarterly",
          "SemiMonthly",
          "Hourly",
          "Daily",
          "SemiAnnually",
          "13xPerYear",
          "11xPerYear",
          "10xPerYear",
          "Once"
        )
        ContactInformationCategoryCode = String.enum(
          "Home",
          "Work",
          "Employer",
          "Friend",
          "Mailing",
          "DesignatedOrganization",
          "DesignatedPerson",
          "Self",
          "Mobile",
          "Residency",
          "Transient"
        )
        ReferralActivityStatusCode = String.enum(
          "Initiated",
          "Accepted",
          "Rejected",
          "ProvisionallyAccepted",
          "Updated",
          "PartiallyRejected"
        )
        FamilyRelationshipHIPAACode = String.enum(
          "01",
          "03",
          "04",
          "05",
          "06",
          "07",
          "08",
          "09",
          "10",
          "11",
          "12",
          "13",
          "14",
          "15",
          "16",
          "17",
          "18",
          "19",
          "23",
          "24",
          "25",
          "26",
          "31",
          "38",
          "53",
          "60",
          "D2",
          "G8",
          "G9",
          "03-53",
          "53-19"
        )
      end
    end
  end
end