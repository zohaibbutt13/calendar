require 'date'
require_relative 'event_info'
require 'colorize'

class Calendar
  def initialize
    @all_events = {}
  end

  def put_event date
    count = 0
    @all_events.each do |key, value|
      if key == date
        count = value.length
      end
    end
    count
  end

  def show_calendar(month, year)
    total_days = Date.new(year,month,-1).mday
    tabs = Date.parse(Time.now.strftime("01/%m/%Y")).wday
    puts "S\tM\tT\tW\tT\tF\tS\t".blue
    @i = 0

    tabs.times do 
      print "\t"
      @i += 1
    end

    total_days.times do |day|
      count = put_event("#{day + 1}-#{month}-#{year}")
      if count > 0
        print "#{day + 1}(#{count})\t".blue
      else
        print "#{day + 1} \t"
      end
      @i += 1
      if @i % 7 == 0
        puts ""
      end
    end
    puts ""
    puts ""
  end

  def current_month_calendar
    time = Time.now
    month = time.month
    year = time.year
    show_calendar(month, year)
  end

  def any_month_calendar
    month = 0
    year = 0
    loop do
      begin
        loop do
          print "Enter year: "
          year = Integer(gets)
          if year != nil && year != "" && year >= 1500 && year <= 3000
            break
          else
            puts "Year can be between 1500 to 3000".yellow
          end
        end
        loop do
          print "Enter month: "
          month = Integer(gets)
          if month != nil && month != "" && month >= 1 && month <= 12
            break
          else
            puts "Month can be between 1 to 12".yellow
          end
        end
        if Date.valid_date?(year,month,1)
          show_calendar(month, year)
          break
        else
          puts "Invalid date".red
        end
        break
      rescue => e
        #puts e.message
        #p e.backtrace.join("\n")
        puts "Invalid input".red
        puts ""
      end
    end
  end

  def add_event
    date = validate_date
    title = nil
    desc = nil
    venue = nil
  loop do
    begin
        print "Enter title: "
        title = gets.chomp
        if title != nil && title != ""
          break
        end
      rescue
        puts "Invalid Input"
      end
    end
    print "Enter description: "
    desc = gets.chomp
    print "Enter venue: "
    venue = gets.chomp

    event_object = EventInfo.new(title,desc,venue)
    if @all_events.has_key? date
      @all_events[date].push event_object
    else
      @all_events[date] = [event_object]
    end
    puts "Event added successfuly".green
    puts ""
  end

  def validate_date
    day = 0
    month = 0
    year = 0
    loop do
      loop do
        begin
          print "Enter year: "
          year = Integer(gets)
          if year != nil && year != 0 && year > 1500 && year < 3000
            break
          else
            puts "Year can be between 1500 to 3000".yellow
          end
        rescue
          puts "Invalid Year".red
        end
      end

      loop do
        begin
          print "Enter month: "
          month = Integer(gets)
          if month != nil && month != 0 && month >= 1 && month <= 12
            break
          else
            puts "Month value can be between 1 to 12".yellow
          end
        rescue
          puts "Invalid Month".red
        end
      end

      loop do
        begin
          print "Enter day: "
          day = Integer(gets)
          if day != nil && day != 0 && day >= 1 && day <= 31
            break
          else
            puts "Day value can be between 1 to 31".yellow
          end
        rescue
          puts "Invalid Day".red
        end
      end

      if Date.valid_date?(year, month, day)
        break      
      else
        puts "Invalid date".yellow
      end
    end
    "#{day}-#{month}-#{year}"
  end

  def show_event
    date = validate_date
    puts ""
    events = @all_events[date]
    if events != nil
      puts "---------- Date: #{date} ----------".blue
      events.each do |item|
        puts "Title: #{item.title}"
        puts "Description: #{item.description}"
        puts "Venue: #{item.venue}"
        puts ""
        if events.length > 1
          puts "--------------------------------------".blue
        end
      end
    else
      puts "No event on the given date".red
    end
    puts ""
  end
end

#obj = Calendar.new
#obj.show_current_calender 