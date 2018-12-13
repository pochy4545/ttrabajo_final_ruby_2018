require "rails_helper"
RSpec.describe Question, :type => :model do
  
  let(:question) { FactoryBot.build(:question_with_answers) }
  
  it "is a valid quest" do
    expect(question).to be_valid
  end
  
  describe "relaciones" do
    it {expect(question).to have_many(:answers).dependent(:destroy)}
    it {expect(question).to belong_to(:user)}
  end

  describe "validaciones" do
    it {expect(question).to validate_presence_of(:title)}
    it {expect(question).to validate_presence_of(:description)}
  end

 end