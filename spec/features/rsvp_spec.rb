require_relative '../rails_helper'

feature "RSVP", js: true do
  scenario "creating an rsvp, YES happy path" do
    visit '/'
    click_on 'RSVP'
    fill_in "rsvp_first_name", with: "Jeff"
    fill_in "rsvp_last_name", with: "Gran"
    fill_in "rsvp_email", with: "jeff.gran@gmail.com"

    expect(page).to_not have_select('rsvp[party_size]')
    expect(page).to_not have_css('#guest_name_1')
    expect(page).to_not have_css('#guest_meal_1')

    select "Yes!", from: 'rsvp[coming]'
    
    expect(page).to have_select('rsvp[party_size]')
    expect(page).to have_css('#guest_name_1')
    expect(page).to have_css('#guest_meal_1')
    
    expect(page).to_not have_css('#guest_name_2')
    expect(page).to_not have_css('#guest_meal_2')
    
    select "2", from: 'rsvp[party_size]'
    
    expect(page).to have_css('#guest_name_2')
    expect(page).to have_css('#guest_meal_2')

    fill_in "guest_name_1", with: "Jeff Gran"
    select_option("steak", "guest_meal_1")

    fill_in "guest_name_2", with: "Ann Guerra"
    select_option("vegetarian", "guest_meal_2")

    click_on "Respond"

    expect(page).to have_content("Thank you")
    expect(page).to have_content("glad you can make it")
    rsvp = Rsvp.last
    expect(rsvp.first_name).to eq "Jeff"
    expect(rsvp.last_name).to eq "Gran"
    expect(rsvp.email).to eq "jeff.gran@gmail.com"
    expect(rsvp.coming).to be true
    expect(rsvp.party_size).to be 2
  end

  scenario "creating an rsvp, NO happy path" do
    visit '/'
    click_on 'RSVP'
    fill_in "rsvp_first_name", with: "Jeff"
    fill_in "rsvp_last_name", with: "Gran"
    fill_in "rsvp_email", with: "jeff.gran@gmail.com"

    expect(page).to_not have_select('rsvp[party_size]')
    expect(page).to_not have_css('#guest_name_1')
    expect(page).to_not have_css('#guest_meal_1')
    
    select "No", from: 'rsvp[coming]'
    
    expect(page).to_not have_select('rsvp[party_size]')
    expect(page).to_not have_css('#guest_name_1')
    expect(page).to_not have_css('#guest_meal_1')
    
    click_on "Respond"

    expect(page).to have_content("Thank you")
    expect(page).to have_content("Sorry")
    rsvp = Rsvp.last
    expect(rsvp.first_name).to eq "Jeff"
    expect(rsvp.last_name).to eq "Gran"
    expect(rsvp.email).to eq "jeff.gran@gmail.com"
    expect(rsvp.coming).to be false
    expect(rsvp.party_size).to be_blank
  end

  scenario "creating an rsvp, validation errors" do
    visit '/'
    click_on 'RSVP'
    click_on "Respond"

    expect(page).to have_content("vous")
    fill_in "rsvp_first_name", with: "Jeff"
    click_on "Respond"
    
    expect(page).to have_content("vous")
    fill_in "rsvp_last_name", with: "Gran"
    click_on "Respond"
    
    expect(page).to have_content("vous")
    fill_in "rsvp_email", with: "sumthin"
    click_on "Respond"

    expect(page).to have_content("vous")
    select "Yes", from: 'rsvp[coming]'
    click_on "Respond"

    expect(page).to have_content("vous")
    select "Yes", from: 'rsvp[coming]'
    click_on "Respond"
    
    expect(page).to have_select('rsvp[party_size]')
    expect(page).to have_css('#guest_name_1')
    expect(page).to have_css('#guest_meal_1')

    expect(page).to have_content("vous")
    fill_in "guest_name_1", with: "Jeff Gran"
    click_on "Respond"
    
    expect(page).to have_content("vous")
    select_option("steak", "guest_meal_1")
    click_on "Respond"
    

    click_on "Respond"
    expect(page).to have_content("Email Address is invalid")
    fill_in "rsvp_email", with: "jeff.gran@gmail.com"
    click_on "Respond"
    
    expect(page).to have_content("Thank you")
    rsvp = Rsvp.last
    expect(rsvp.first_name).to eq "Jeff"
    expect(rsvp.last_name).to eq "Gran"
    expect(rsvp.email).to eq "jeff.gran@gmail.com"
    expect(rsvp.party_size).to be 1
    expect(rsvp.guests.size).to be 1
    expect(rsvp.guests.first.name).to eq "Jeff Gran"
    expect(rsvp.guests.first.meal).to eq "steak"
  end

  scenario "editing an existing RSVP by using the same email address again" do
    Rsvp.create!({
                   first_name: "Jeff",
                   last_name: "Gran",
                   email: 'jeff.gran@gmail.com',
                   coming: true,
                   party_size: 1,
                   guests_attributes: [
                     { name: "Jeff", meal: 'steak' }
                   ]
                 })
    visit '/'
    click_on 'RSVP'

    fill_in "rsvp_first_name", with: "Ffej"
    fill_in "rsvp_last_name", with: "Narg"
    fill_in "rsvp_email", with: "jeff.gran@gmail.com"
    
    select "No.", from: 'rsvp[coming]'

    click_on "Respond"

    expect(Rsvp.count).to eq 1
    rsvp = Rsvp.last
    expect(rsvp.first_name).to eq "Ffej"
    expect(rsvp.last_name).to eq "Narg"
    expect(rsvp.coming).to be false
    expect(rsvp.guests.count).to eq 0
  end

  def select_option(value, from_id)
    within "##{from_id}" do
      find("option[value=#{value}]").select_option
    end
  end
end
