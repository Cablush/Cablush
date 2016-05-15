require "rails_helper"

describe Usuario do

  let (:usuario) { create(:usuario) }

  it "should be valid" do
    expect(usuario.valid?).to be_truthy
  end

  it "should save" do
    expect(usuario.save).to be_truthy
  end

  it "does not allow duplicate email" do
    used_email = Faker::Internet.email
    create(:usuario, email: used_email)
    expect(build(:usuario, email: used_email)).to_not be_valid
  end

end
