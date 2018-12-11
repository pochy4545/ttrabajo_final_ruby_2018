require "rails_helper"
RSpec.describe User, :type => :model do
  
  let(:user) { FactoryBot.build(:user_with_questions) }
  
  it "is a valid user" do
    expect(user).to be_valid
  end


   describe 'validaciones' do
    it {expect(user).to have_many(:questions)}
    it { expect(user).to have_many(:questions).dependent(:destroy) }
    it {expect(user).to validate_uniqueness_of(:username)}
    it {expect(user).to validate_uniqueness_of(:email)}
    #it {expect(user).to validate_uniqueness_of(:token)}
    it {expect(user).to validate_presence_of(:username)}
    it {expect(user).to validate_presence_of(:password)}
    it {expect(user).to validate_presence_of(:screen_name)}
    it {expect(user).to validate_presence_of(:email)}
   end
 end