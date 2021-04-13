# frozen_string_literal: true

module AcaEntities
  module Functions
    class PrimaryApplicantBuilder
      # extend Dry::Transformer::Registry
      # import Dry::Transformer::Coercions

      def self.call(name, data)
        Hash[name, data.values.first]
      end

      # def initialize
      #   to_proc
      # end

      # private

      # def to_proc
      #   # binding.pry
      #   # ->(arg1) {age_on(arg1)}

      #   ->(payload) {execute(payload)}
      # end

      # def execute(payload)
      #   binding.pry
      # end

      # # Convert dob to age
      # #
      # # @param dob The input dob
      # # @param on_date The age on the given date
      # #
      # # @example
      # #   dob: Date.new(1980,1,1), on_date: Date.new(2021,1,1)
      # #   # =>  41
      # #
      # # @return age
      # def age_on(dob, on_date: @on_date || Date.today)
      #   dob = t(:to_date)[dob]
      #   on_date = t(:to_date)[on_date]
      #   age = on_date.year - dob.to_date.year
      #   return age - 1 unless on_date.month > dob.month || (on_date.month == dob.month && on_date.day >= dob.day)
      #   age
      # end

      def t(*args)
        AcaEntities::Functions::AgeOn[*args]
      end
    end
  end
end