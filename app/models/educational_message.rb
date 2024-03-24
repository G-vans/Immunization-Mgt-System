class EducationalMessage < ApplicationRecord
  belongs_to :medic

  CATEGORY_NAMES = [
    "Newborn Care",
    "Breastfeeding Support",
    "Postpartum Depression Awareness",
    "Mental Health Support"
].freeze

  DURATION_TIMES = [
    "0 - 3 Months",
    "4 - 6 Months",
    "7 - 9 Months",
    "10 - 12 Months"
  ]

end
