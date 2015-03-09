require_relative '../rails_helper'

feature "RSVP" do
  scenario "creating an rsvp, YES happy path" do
    visit '/'
    click_on 'RSVP'
    fill_in "rsvp_first_name", with: "Jeff"
    fill_in "rsvp_last_name", with: "Gran"
    fill_in "rsvp_email", with: "jeff.gran@gmail.com"
    choose "Yes", between: 'rsvp_coming'
    select "2", from: 'rsvp_party_size'
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
    choose "No", between: 'rsvp_coming'
    select "2", from: 'rsvp_party_size'
    click_on "Respond"

    expect(page).to have_content("Thank you")
    expect(page).to have_content("sorry")
    rsvp = Rsvp.last
    expect(rsvp.first_name).to eq "Jeff"
    expect(rsvp.last_name).to eq "Gran"
    expect(rsvp.email).to eq "jeff.gran@gmail.com"
    expect(rsvp.coming).to be true
    expect(rsvp.party_size).to be 2
  end

  scenario "creating an rsvp, validation errors", js: true do
    visit '/'
    click_on 'RSVP'
    click_on "Respond"

    expect(page).to have_content("there was a problem saving your RSVP")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email Address can't be blank")
    expect(page).to have_content("Email Address is invalid")
    expect(page).to have_content("We need to know whether you can make it")
    fill_in "rsvp_email", with: "sumthin"
    click_on "Respond"
    expect(page).to have_content("Email Address is invalid")
  end
  
end
