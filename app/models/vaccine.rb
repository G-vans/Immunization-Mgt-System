class Vaccine < ApplicationRecord

    VACCINE_STATUS = [
        "In-Stock",
        "Out-of-Stock"
].freeze

    # low stock logic
  def self.low_stock
    where("quantity <= ?", 10)
  end

end
