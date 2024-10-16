# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class Application < Dry::Struct

        # @!attribute [r] name
        # A string representing the application, only for the use of the submitter
        # @return [String]
        attribute :name,              Types::String.meta(omittable: false)

        # @!attribute [r] state
        # The state of the application.  2 character state code.  For example, "CA"
        # @return [String]
        attribute :state,             Types::UsStateAbbreviationKind.meta(omittable: false)

        # @!attribute [r] application_year
        # Optional field. The year during which the application is being submitted (allows you
        # to submit an application for a future year for testing purposes). For the purposes of
        # Medicaid eligibility, the year begins on April 1. If left blank, MitC will assume the
        # application is for the current year
        # @return [String]
        attribute :application_year,    Types::Integer.meta(omittable: false)

        # @!attribute [r] people
        # The list of {People} who are party to this Application
        # @return [Array<Person>]
        attribute :people,              Types::Array.of(Person).meta(omittable: false)

        # @!attribute [r] households
        # How the Application's People are organized into physical households
        # @return [Array<Household>]
        attribute :physical_households, Types::Array.of(Household).meta(omittable: false)

        # @!attribute [r] tax_returns
        #
        # @return [Array<Person>]
        attribute :tax_returns,         Types::Array.of(TaxReturn).meta(omittable: false)
      end
    end
  end
end
