require 'redcarpet'

module Contentful
  class Recipe
    extend Contentful::Base

    class RecipeNotFound < StandardError; end

    Recipe = Struct.new(:id, :title, :photo_url, :tags, :description, :chef_name, keyword_init: true)

    class << self
      def entry(id)
        recipe = client.entry(id)
        raise RecipeNotFound if recipe.nil?

        Recipe.new(
          title: recipe.title,
          photo_url: recipe.photo&.url,
          tags: tags(recipe&.fields[:tags]),
          description: markdown.render(recipe.description || ''),
          chef_name: chef_name(recipe&.fields[:chef])
        )
      end

      private

      def tags(tags)
        tags.map(&:name) if tags.present?
      end

      def chef_name(chef)
        chef&.fields[:name] if chef.present?
      end

      def markdown
        renderer = Redcarpet::Render::HTML.new({})
        extensions = {}
        Redcarpet::Markdown.new(renderer, extensions)
      end
    end
  end
end
