# bundle exec rspec spec/features/dogs_spec.rb

require 'rails_helper'

RSpec.feature 'Dog Submissions', type: :feature do
  scenario 'User submits a valid dog breed' do
    visit new_dog_path

    # Assuming 'Dog breed requested successfully!' is the success flash message
    expect(page).not_to have_content('Dog breed requested successfully!')

    # Fill in the breed field with a valid value
    select 'african', from: 'dog_breed'
    click_button 'Submit'

    # Expect the success flash message
    expect(page).to have_content('Dog breed requested successfully!')
    expect(page).to have_css('img[src^="https://images.dog.ceo/breeds/"]')
    expect(Dog.first.breed).to eq('african')
  end
end
