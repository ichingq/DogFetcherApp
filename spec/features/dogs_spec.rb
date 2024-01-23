# spec/features/dogs_spec.rb

require 'rails_helper'

RSpec.feature 'Dog Submissions', type: :feature do
  scenario 'User submits a valid dog breed' do
    visit new_dog_path

    # Assuming 'Dog breed submitted successfully!' is the success flash message
    expect(page).not_to have_content('Dog breed submitted successfully!')

    # Fill in the breed field with a valid value
    select 'african', from: 'dog_breed'
    click_button 'Submit'

    # Expect the success flash message
    expect(page).to have_content('Dog breed submitted successfully!')
    expect(page).to have_css('img[src^="https://images.dog.ceo/breeds/"]')
  end
end
