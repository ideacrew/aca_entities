module Ehs
  module MagiMedicaidEligibilityDeterminations
    class MagiMedicaidEligibilityDeterminationValueObject < Sequent::ValueObject
      attrs person_ids: array(String),
            incomes: array(::Ehs::FinancialStatements::IncomeValueObject),
            magi_medicaid_application_id: String

      def self.from_entity(determination)
        person_ids = determination.tax_households.flat_map(&:tax_household_members).flat_map(&:person_identifiers).map(&:to_uri)
        income_items = determination.tax_households.flat_map(&:tax_household_members).flat_map(&:financial_statements).flat_map(&:incomes)
        incomes = income_items.map do |income|
          ::Ehs::FinancialStatements::IncomeValueObject.new({
            amount: BigDecimal(income.amount.to_s),
            kind: income.type,
            frequency: income.frequency,
            start_date: income.start_date,
            end_date: income.end_date
          })
        end
        self.new({
          person_ids: person_ids,
          incomes: incomes
        })
      end
    end
  end
end
