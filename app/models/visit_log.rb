class VisitLog < ApplicationRecord
  belongs_to :shift
  enum event_type: { start: 'start', end: 'end' }

  validates :latitude, :longitude, presence: true
end
