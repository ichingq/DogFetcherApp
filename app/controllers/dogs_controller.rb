# app/controllers/dogs_controller.rb

require 'rest-client'

class DogsController < ApplicationController

 before_action :set_dog_breeds, only: [:new, :create]

  def new
    @dog = Dog.new
    @dog_image = params[:dog_image]
    @dog_breeds = fetch_dog_breeds
    Rails.logger.debug("@dog_breeds: #{@dog_breeds.inspect}")
  end

  def create
    @dog = Dog.new(dog_params)

    if @dog.save
      @dog_image = fetch_dog_image(@dog.breed)
      flash[:success] = 'Dog breed submitted successfully!'
      respond_to do |format|
        format.html { render :new, locals: { dog: @dog, dog_image: @dog_image, dog_breeds: @dog_breeds } }
        format.js   
      end
    else
      flash[:error] = 'Error submitting dog breed.'
      render :new
    end
  end

  private

  def set_dog_breeds
    @dog_breeds = fetch_dog_breeds
  end

  def dog_params
    params.require(:dog).permit(:breed)
  end

  def fetch_dog_image(breed)
    response = RestClient.get("https://dog.ceo/api/breed/#{breed}/images/random")
    json_response = JSON.parse(response.body)
    json_response['message']
  rescue RestClient::ExceptionWithResponse => e
    # Handle API request errors gracefully
    Rails.logger.error("Error fetching dog image: #{e.message}")
    nil
  end

  def fetch_dog_breeds
    response = RestClient.get("https://dog.ceo/api/breeds/list/all")
    @dog_breeds = JSON.parse(response.body)['message'].keys
  rescue RestClient::ExceptionWithResponse => e
    Rails.logger.error("Error fetching dog breeds: #{e.message}")
    @dog_breeds = []
  end

end
