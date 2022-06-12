require 'will_paginate/array'

class RecipesController < ApplicationController
  def index
    client = Contentful::Recipes.new(params[:page])
    @recipes = client.entries
    @pages = (1..client.page_count).to_a.paginate(page: params[:page], per_page: Contentful::Recipes::PER_PAGE)
  end

  def show
    @recipe = Contentful::Recipe.entry(params[:id])
  end
end
