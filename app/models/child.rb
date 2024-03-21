class Child < ApplicationRecord
    has_many :immunization_schedules

    LANGUAGES = [
    "English",
    "Kiswahili",
    "Luo"
  ].freeze
end
