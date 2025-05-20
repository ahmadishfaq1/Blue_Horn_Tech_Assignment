class Shift < ApplicationRecord
  belongs_to :caregiver
  belongs_to :client
  has_many :visit_logs

  def started?
    last_event = visit_logs.order(:timestamp).last
    last_event&.event_type == 'start'
  end

  def ended?
    last_event = visit_logs.order(:timestamp).last
    last_event&.event_type == 'end'
  end

  def start_visit(latitude, longitude)
    return false if started?

    visit_logs.create(
      event_type: 'start',
      timestamp: Time.current,
      latitude: latitude,
      longitude: longitude
    )
  end

  def end_visit(latitude, longitude)
    return false unless started?

    visit_logs.create(
      event_type: 'end',
      timestamp: Time.current,
      latitude: latitude,
      longitude: longitude
    )
  end
end
