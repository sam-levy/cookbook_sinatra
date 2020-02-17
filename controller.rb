require_relative "view"
require_relative "recipe"
require_relative "fetch"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    name = @view.ask_for("name")
    description = @view.ask_for("description")
    recipe = Recipe.new(name, description)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    display_recipes
    recipe_index = @view.ask_for("index").to_i
    @cookbook.remove_recipe(recipe_index - 1)
  end

  def fetch_bbc
    ingredient = @view.ask_for('Please type an ingredient')
    recipes = Fetch.bbc(ingredient)
    @view.display(recipes)
    recipe_index = @view.ask_for('Please type a recipe index').to_i
    recipe = recipes[recipe_index - 1] 
    @cookbook.add_recipe(recipe)
  end

  private

  def display_recipes
    recipes = @cookbook.all
    @view.display(recipes)
  end
end