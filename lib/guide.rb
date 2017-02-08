require 'restaurant'
class Guide

  class Config
    @@actions = ['list','find', 'add', 'quit']

    def self.actions
      @@actions
    end
  end

  def initialize(path=nil)
    # locate the restaurant text file at path
    Restaurant.filepath = path
    if Restaurant.file_usable?
      puts "Found restaurant.txt file."
      # or create a new file
    elsif Restaurant.create_file
      puts "Created restaurant.txt file."
      # exit if create fails
    else
      puts "Exiting.\n\n"
      exit!
    end
  end

  def launch!
    introduction
    # action loop
    result = nil
    until result ==:quit
      action = get_action
      result = do_action(action )
    end
    conclusion
  end

  def get_action
    action = nil

    # request input until valid action is submitted
    until Guide::Config.actions.include?(action)
      puts 'Actions:' + Guide::Config.actions.join(', ') if action
      print '> '
      user_response = gets.chomp
      action = user_response.downcase.strip
    end

    return action
  end

  def do_action(action)
    case action
      when 'list'
        list
      when 'find'
        puts 'Finding...'
      when 'add'
        add
      when 'quit'
        return :quit
      else
        puts "\n I didn't get that command...\n"
        
    end
  end

  def list
    puts "\n Listing joints... \n\n".upcase

    restaurants = Restaurant.saved_restaurants
    restaurants.each do |restaurant|
      puts restaurant.name + ' | ' + restaurant.cuisine + ' | ' + restaurant.location + ' | ' + restaurant.price
    end
  end

  def find

  end

  def add
    puts "\n Add a joint\n\n".upcase

    restaurant = Restaurant.build_query

    if restaurant.save
      puts "\nJoint added to listing!\n\n"
    else
      puts "\nError: Joint not added.\n\n"
    end
  end

  def introduction
    puts "\n\n<<< Welcome to the Food Radar! >>>\n\n"
    puts "This is an interactive guide to help you find the food you crave.\n\n"
  end

  def conclusion
    puts "\n<<< Goodbye and enjoy your meal! >>>\n\n\n"
  end

end
