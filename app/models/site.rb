class Site < ActiveRecord::Base

  def self.all_activities_nike
    activity_1 = {
      userId: 123456789,
      activityType: "Run",
      activityTimeZone: Time.zone.now-1.day,
      totalDuration: "10:52:26.000",
      totalDistance: 500
    }
  end

  def self.all_activities_runtastic
    activity_1 = {
      userId: 123456789,
      activityType: "Run",
      activityTimeZone: Time.zone.now-1.day,
      totalDuration: "10:52:26.000",
      totalDistance: 0
    }
  end

end
