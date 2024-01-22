# spec/features/dogs_spec.rb

require 'rails_helper'

RSpec.feature 'Dog Submissions', type: :feature do
  scenario 'User submits a valid dog breed' do
    # Your test logic here
  end

  scenario 'User cannot submit form with an empty dog breed field' do
    visit new_dog_path
    click_button 'Submit'
    expect(page).to have_content('Dog breed submitted successfully!')
  end
end
