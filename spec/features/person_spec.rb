require 'rails_helper'
require 'capybara/rails'

feature 'Person' do

  scenario 'Users can see a persons show page' do
    create_user email: "user@example.com"
    person = create_person
    visit root_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name
    within 'h1' do
      expect(page).to have_content(person.full_name)
    end
  end

  scenario 'Users can edit people' do
    create_user email: "user@example.com"
    person = create_person
    visit root_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name

    click_on 'Edit'
    fill_in 'Title', :with => 'Dr.'
    fill_in 'First Name', :with => 'Quinn'
    fill_in 'Last Name', :with => 'Medicine Woman'
    click_on 'Update User'
    within '.table' do
      expect(page).to have_content('Dr. Quinn Medicine Woman')
    end
  end

  scenario 'Users must enter a title/last_name or first_name/last_name' do
    create_user email: "user@example.com"
    person = create_person
    visit root_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name

    click_on 'Edit'
    fill_in 'Title', :with => ''
    fill_in 'First Name', :with => ''
    fill_in 'Last Name', :with => ''

    click_on 'Update User'
    expect(page).to have_content('Title or First Name must be entered.')
    expect(page).to have_content("Last name can't be blank")

  end

end
