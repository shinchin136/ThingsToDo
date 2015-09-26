class Itinerary < ActiveRecord::Base
  belongs_to :user
  has_many :events

  after_create :fetch_events

  def fetch_events
    query = "http://api.eventful.com/rest/events/search?app_key=v6mgZRgw6VGgNmVn&location=#{city},%20#{country}&date=#{start_date}00-#{end_date}00"
    data = RestClient.get(query)
    result = Hash.from_xml data

    result["search"]["events"]["event"].each do |event|
      events.create title: event["title"], description: event["description"], venue: event["venue_name"], start_time: event["start_time"], end_time: event["stop_time"], all_day: event["all_day"] != 0, address: event["venue_address"]
    end
  end
end
