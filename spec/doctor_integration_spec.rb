require('capybara/rspec')
require('spec_helper')
require('./app')
require('patient')
require('doctor')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('add a new doctor route', {:type => :feature}) do
  it('allows a user to add a doctor') do
    visit('/')
    fill_in('first_name', :with => 'Bob')
    fill_in('last_name', :with => 'Blahblah')
    fill_in('speciality_name', :with => 'Pediatrics')
    click_button('Add Doctor')
    click_link('Return Home')
    expect(page).to have_content('Dr. Blahblah')
  end
end

describe('add a new patient route', {:type => :feature}) do
  it('allows a user to add a doctor') do
    visit('/')
    fill_in('first_name', :with => 'Bob')
    fill_in('last_name', :with => 'Blahblah')
    fill_in('speciality_name', :with => 'Pediatrics')
    click_button('Add Doctor')
    click_link('Return Home')
    click_link('Dr. Blahblah - 0 Patients')
    fill_in('first_name', :with => 'Jane')
    fill_in('last_name', :with => 'Doe')
    fill_in('birthdate', :with => '1992-05-01')
    click_button('Add Patient')
    click_link('Return Home')
    click_link('Dr. Blahblah - 1 Patients')
    expect(page).to have_content('Jane Doe')
  end
end

describe('filter doctors by speciality route', {:type => :feature}) do
  it('allows a user to filter doctors by speciality') do
    visit('/')
    fill_in('first_name', :with => 'Bob')
    fill_in('last_name', :with => 'Blahblah')
    fill_in('speciality_name', :with => 'Pediatrics')
    click_button('Add Doctor')
    click_link('Return Home')
    fill_in('first_name', :with => 'Sarah')
    fill_in('last_name', :with => 'Conor')
    fill_in('speciality_name', :with => 'Internal Medicine')
    click_button('Add Doctor')
    click_link('Return Home')
    select('Pediatrics', :from => 'speciality_name')
    click_button('Filter by Speciality')
    expect(page).to have_content('Blahblah')
  end
end
