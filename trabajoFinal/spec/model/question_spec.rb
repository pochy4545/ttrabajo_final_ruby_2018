require "rails_helper"
RSpec.describe Question, :type => :model do
  
  let(:question) { FactoryBot.build(:question) }
  
  it "is a valid quest" do
    expect(question).to be_valid
  end


 end