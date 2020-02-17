class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end
  
  def run
    print `clear`
    puts "", "###########################",""
    puts "Welcome to the cookbook"
    puts "", "###########################",""

    while @running
      puts "Please select an option"
      puts "        --            "
      puts "1 - Create a recipe"
      puts "2 - List recipes"
      puts "3 - Remove recipe"
      puts "4 - Fetch from BBC"
      puts "9 - Exit"
      action = gets.chomp.to_i
      print `clear`

      case action
      when 1 then @controller.create
      when 2 then @controller.list
      when 3 then @controller.destroy
      when 4 then @controller.fetch_bbc
      when 9 then @running = false
      else
        puts "Please select a valid option"
      end
    end
  end
end