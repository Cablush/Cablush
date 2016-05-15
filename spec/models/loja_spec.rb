require "rails_helper"

describe Loja do
  it "has a valid factory" do
    create(:loja).should be_valid
  end

end
