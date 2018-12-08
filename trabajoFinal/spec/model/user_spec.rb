require "rails_helper"
RSpec.describe User, :type => :model do
  
  before(:all) do
    @user1 = create(:user)
  end
  
  
  it "username tiene que ser unico" do
    user2 = build(:user, username: "agustin")
    expect(user2).to_not be_valid
  end
  
  it "email tiene que ser unico" do
    user2 = build(:user, email: "agustin.c.96@hotmail.com")
    expect(user2).to_not be_valid
  end
  
  it "password invalido" do 
    user2 = build(:user, password: nil)
    expect(user2).to_not be_valid
  end
  
  it "username invalido" do 
    user2 = build(:user, username: nil)
    expect(user2).to_not be_valid
  end
  
  it "email invalido" do
    user2 = build(:user, email: nil)
    expect(user2).to_not be_valid
  end
  it "screen_name invalido" do
    user2 = build(:user, screen_name: nil)
    expect(user2).to_not be_valid
  end
  
end