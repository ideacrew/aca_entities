# frozen_string_literal: true

module AcaEntities
  module Functions
    # Calculate age based on date of birth and on given date
    class AgeOn
      extend Dry::Transformer::Registry
      import Dry::Transformer::Coercions
      attr_accessor :on_date

      def initialize(on_date: Date.today)
        @on_date = on_date
        # to_proc
      end

      def call(value)
        age_on(value)
      end

      private

      # @api private
      # def to_proc
      #   ->(arg1) {age_on(arg1)}
      # end

      # Convert dob to age
      #
      # @param dob The input dob, either date as string or date as object
      # @param on_date The input date, either date as string or date as object
      #
      # @example
      #   dob: "1980-1-1", on_date: "2021-1-1"
      #   # =>  41
      #
      # @return age
      #
      # @example
      #   dob: Date.new(1980,1,1), on_date: Date.new(2021,1,1)
      #   # =>  41
      #
      # @return age
      #
      # @api private
      def age_on(dob, on_date: @on_date || Date.today)
        dob = (t(:to_string).>>t(:to_date))[dob]
        on_date = (t(:to_string).>>t(:to_date))[on_date]
        age = on_date.year - dob.to_date.year
        return age - 1 unless on_date.month > dob.month || (on_date.month == dob.month && on_date.day >= dob.day)
        age
      end

      # @api private
      def t(*args)
        AcaEntities::Functions::AgeOn[*args]
      end
    end
  end
end