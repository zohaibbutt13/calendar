require 'date'
require_relative 'event_info'
require 'colorize'

class Calendar
  def initialize
    @all_events = {}
    @event_object = EventInfo.new
  end
  def get_event_count(date)
    no_of_events = 0
    if @all_events.has_key? date
      no_of_events = @all_events[date].length
    end
    no_of_events
  end

  def show_calendar(month = Time.now.month, year = Time.now.year)
    tabs = Date.parse(Time.new(year,month).strftime("01/%m/%Y")).wday
    puts "S\tM\tT\tW\tT\tF\tS\t".blue

    print "\t"*tabs

    Date.new(year, month, -1).mday.times do |day|
      count = get_event_count("#{day + 1}-#{month}-#{year}")
      if count > 0
        print "#{day + 1}(#{count})\t".blue
      else
        print "#{day + 1} \t"
      end
      if Date.parse("#{year}-#{month}-#{day + 1}").to_date.saturday?
        puts ""
      end
    end
    puts ""
    puts ""
  end

  def any_month_calendar
    month = 0
    year = 0
    loop do
      begin
        loop do
          print "Enter year: "
          year = Integer(gets)
          if year != nil && year != "" && year >= 0
            break
          else
            puts "Year cannot be less than 1".yellow
          end
        end
        loop do
          print "Enter month: "
          month = Integer(gets)
          if Date.valid_date?(year, month, 1)
            show_calendar(month, year)
            break
          else
            puts "Month can be between 1 to 12".yellow
          end
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

    @event_object.title = title
    @event_object.description = desc
    @event_object.venue = venue

    if @all_events.has_key? date
      @all_events[date].push @event_object
    else
      @all_events[date] = [@event_object]
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
          if year != nil && year != 0 && year >= 1
            break
          else
            puts "Year cannot be less than 1".yellow
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
    if events
      puts "---------- Date: #{date} ----------".blue
      events.each do |event|
        puts "Title: #{event.title}"
        puts "Description: #{event.description}"
        puts "Venue: #{event.venue}"
        puts ""
        if events.length > 1
          puts "--------------------------------------".blue
        end
      end
    else
      puts "No event on the given date".yellow
    end
    puts ""
  end
end