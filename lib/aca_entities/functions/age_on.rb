# frozen_string_literal: true

module AcaEntities
  module Functions
    class AgeOn
      extend Dry::Transformer::Registry
      import Dry::Transformer::Coercions
      attr_accessor :on_date

      def initialize(on_date: Date.today)
        @on_date = on_date
        to_proc
      end

      private

      def to_proc
        ->(arg1) {age_on(arg1)}
      end

      # Convert dob to age
      #
      # @param dob The input dob
      # @param on_date The age on the given date
      #
      # @example
      #   dob: Date.new(1980,1,1), on_date: Date.new(2021,1,1)
      #   # =>  41
      #
      # @return age
      def age_on(dob, on_date: @on_date || Date.today)
        dob = t(:to_date)[dob]
        on_date = t(:to_date)[on_date]
        age = on_date.year - dob.to_date.year
        return age - 1 unless on_date.month > dob.month || (on_date.month == dob.month && on_date.day >= dob.day)
        age
      end

      def t(*args)
        AcaEntities::Functions::AgeOn[*args]
      end
    end
  end
end