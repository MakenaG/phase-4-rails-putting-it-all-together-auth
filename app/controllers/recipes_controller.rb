class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    before_action :authorize

    def create 
        user = User.find(session[:user_id].to_i)
        recipe = user.recipes.create!(recipe_params)
        render json:recipe, include: :user, status: :created
    end

    def index 
        recipes = Recipe.all
        render json: recipes, include: :user
    end

    private

    def recipe_params 
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
    end
end