require "rails_helper"
RSpec.describe Answer, :type => :model do
  
  let(:answer) { FactoryBot.create(:answer) }
  
  it "is a valid quest" do
    expect(answer).to be_valid
  end
  
  describe "relaciones" do
    it {expect(answer).to belong_to(:user)}
    it {expect(answer).to belong_to(:question)}
  end

  describe "validaciones" do 
    it {expect(answer).to validate_presence_of(:question_id)}
    it {expect(answer).to validate_presence_of(:user_id)}
    it {expect(answer).to validate_presence_of(:content)}

    
  end
  

 end