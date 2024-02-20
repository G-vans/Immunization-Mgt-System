class ImmunizationSchedule < ApplicationRecord
  belongs_to :child
  belongs_to :medic

  VACCINE_NAMES = [
    "2nd Oral polio vaccine; DPT, Hepatitis B and HIB; Pneumococcal vaccine (PCV 10); Rotavirus vaccine (Rotarix)",
    "3rd Oral polio vaccine; DPT, Hepatitis B and HIB; Pneumococcal vaccine (PCV 10); Rotavirus vaccine (Rotarix)",
    "4th Oral polio vaccine; DPT, Hepatitis B and HIB; Pneumococcal vaccine (PCV 10)",
    "Measles vaccine, Vitamin A",
    "Measles vaccine, Yellow Fever vaccine"
  ].freeze
end
