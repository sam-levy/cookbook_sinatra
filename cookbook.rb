require 'CSV'

class Cookbook
  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    load_from_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
   @recipes << recipe 
   save_to_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_to_csv
  end

  private

  def load_from_csv
    CSV.foreach(@csv_file) do  |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def save_to_csv
    CSV.open(@csv_file, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end
end