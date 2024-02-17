class ImmunizationSchedule < ApplicationRecord
  belongs_to :child
  belongs_to :medic
end
