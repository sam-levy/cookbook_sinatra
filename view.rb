class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name}"
      puts ""
    end
  end

  def ask_for(something)
    puts "Type a #{something}"
    gets.chomp
  end
end