namespace :rooms do
  desc 'Creates 10 Temporary Rooms over 24 hours old'
  task create_temporary_old: :environment do
    10.times do |i|
      Room.create!(name: "temp-old-#{i}", created_at: 2.days.ago)
    end
  end

  desc 'Creates 5 Temporary Rooms less than 24 hours old'
  task create_temporary_new: :environment do
    5.times do |i|
      Room.create!(name: "temp-new-#{i}")
    end
  end

  desc 'Destroys all Temporary rooms'
  task destroy_temporary_all: :environment do
    Room.temporary.destroy_all
  end

  desc 'Removes Temporary Rooms over 24 hours old'
  task destroy_temporary_old: :environment do
    @rooms               = Room.temporary
    @time_limit_in_hours = 24

    @rooms.each do |room|
      time_created = room.created_at.to_time
      hours_alive  = ((Time.now - time_created) / 1.hour).floor

      room.destroy if hours_alive > @time_limit_in_hours
    end
  end
end
