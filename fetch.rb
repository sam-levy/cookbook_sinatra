require 'open-uri'
require 'nokogiri'
require_relative "recipe"

class Fetch
  def self.bbc(ingredient)
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"
    doc = open(url)
    object = Nokogiri::HTML(doc)
    
    recipes = []

    object.search('.node-teaser-item').each do |node|
      name = node.search('.teaser-item__title').text.strip
      description = node.search('.teaser-item__text-content').text.strip
      recipes << Recipe.new(name, description)  
    end 

    recipes
  end
end
