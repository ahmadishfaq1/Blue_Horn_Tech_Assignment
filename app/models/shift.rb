class Shift < ApplicationRecord
  belongs_to :caregiver
  belongs_to :client
  has_many :visit_logs

  def start_visit(latitude, longitude)
    visit_logs.create(
      event_type: 'start',
      timestamp: Time.current,
      latitude: latitude,
      longitude: longitude
    )
  end

  def end_visit(latitude, longitude)
    visit_logs.create(
      event_type: 'end',
      timestamp: Time.current,
      latitude: latitude,
      longitude: longitude
    )
  end
end
