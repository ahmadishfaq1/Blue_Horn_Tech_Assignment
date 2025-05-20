class Caregiver < ApplicationRecord
  has_many :shifts
  has_many :visit_logs, through: :shifts
end
