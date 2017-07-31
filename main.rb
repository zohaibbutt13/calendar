require_relative 'event_info'
require 'date'
require_relative 'calendar'

obj = Calendar.new
loop do
  begin
    choice = 0
    puts "1: Add Event"
    puts "2: Show Event"
    puts "3: Show Calandar"
    puts "4: Exit"
    puts ""

    print "Enter Option: "
    choice = Integer(gets)
    puts ""
    
    case choice 
    when 1
  	  obj.add_event
    when 2
  	  obj.show_event
    when 3
      loop do
        begin
          puts "1: Current Month Calendar"
          puts "2: Any Month Calendar"
          temp = Integer(gets)
          case temp 
          when 1
      	    obj.current_month_calendar
            break
          when 2
            obj.any_month_calendar
            break
          else
            puts "Wrong option".red
          end
        rescue => e
          #puts e.message
          #p e.backtrace.join("\n")
          puts "Invalid input".red
        end
      end
    when 4
  	  break
    else
  	  puts "Invalid option".red
    end
  rescue => e
  	#puts e.message
  	#p e.backtrace.join("\n")
  	puts "Invalid input".red
    puts ""
  end
end