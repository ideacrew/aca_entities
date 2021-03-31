# Include the baseline entities and types

module AcaEntities
  module Libraries
    module MagiMedicaidLibrary
      require 'aca_entities/magi_medicaid/types'
      require 'aca_entities/magi_medicaid/contracts/contract'

      require 'aca_entities/magi_medicaid/federal_poverty_level'

      require 'aca_entities/magi_medicaid/contracts/federal_poverty_level_contract'
    end
  end
end
