require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative 'cookbook'
require_relative 'recipe'

# Usamos o método `File.join` para criar um caminho absoluto para o arquivo `recipes.csv`
file_path = File.join(__dir__, 'recipes.csv')
# Criamos uma instancia de `Cookbook` passando o caminho para `recipes.csv`
cookbook = Cookbook.new(file_path)

# Quando o usuario acessar a raiz da URL...
get '/' do
  # Use o método `all` do cookbook (repositório) para retornar todas a instâncias de Recipes e ponha na variável `@recipes`.
  # No Sinatra (e no Rails) o `@` faz com que a variável fique disponível para a view.
  @recipes = cookbook.all
  # Renderiza a view `index.erb` que está na pasta `views`. O Sinatra se guia pelo nome (naming convention).
  # Naming conventions é algo que usaremos muito no Rails.
  erb :index
end

# Quando o usuário acessar o path `/new` da URL (no nosso caso: `http://localhost:4567/new`)...
get "/new" do
  # Renderize a view `new.erb`.
  erb :new
end

# Quando o usuário envia as informações através do formulário (na view `new.erb`) essas informações são direcionadas
# para a rota `/create` usando uma request HTTP do tipo `POST` (vamos ver melhor mais pra frente no curso).
post "/create" do
  # Podemos acessar as informações enviadas usando a hash params (vamos entender melhor depois). Aqui guardamos o nome
  # que o usuário preencheu no formulário na variável `name`.
  name = params[:name]
  # E aqui guardamos o a descrição na variável `description`.
  description = params[:description]
  # Instanciamos uma nova receita com essas informações.
  recipe = Recipe.new(name, description)
  # Usamos o metodo `add_recipe` do `cookbook` para guardar a receita.
  cookbook.add_recipe(recipe)
  # Redirecionameos o usuário para a rota raiz, pois a rota `/create` não possui view.
  redirect '/'
end

# Um path pode conter um `coringa` para um parâmetro. Quando usamos a sintaxe `/recipes/:index` o `:index` será
# substituido por algum número (nesse caso). Esse número vem do link que foi clicado para se chegar nessa URL
# (o X na view `index.erb`).
# Quando o usuário acessa a rota `/recipe/QUALQUER_NUMERO_AQUI`
get "/recipe/:index" do
  # Pegamos o valor de :index usando a hash params, convertemos para inteiro e salvamos na variável `recipe_index`
  recipe_index = params[:index].to_i
  # Usamos o método `remove_recipe` do `cookbook` para remover a receita
  cookbook.remove_recipe(recipe_index)
  # Redirecionameos o usuário para a rota raiz, pois a rota `/recipes/:index` não possui view.
  redirect '/'
end