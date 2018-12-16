require "rails_helper"
RSpec.describe User, :type => :model do
  
  let(:user) { FactoryBot.create(:user_with_questions) }
  #user = FactoryBot.create(:user_with_questions)
  it "is a valid user" do
    expect(user).to be_valid
  end

   describe 'relaciones' do
    it {expect(user).to have_many(:questions)}
    it { expect(user).to have_many(:questions).dependent(:destroy) }

   end

   describe 'validaciones'do 
    it {expect(user).to validate_uniqueness_of(:username)}
    it {expect(user).to validate_uniqueness_of(:email)}
    it {expect(user).to validate_presence_of(:username)}
    it {expect(user).to validate_presence_of(:password)}
    it {expect(user).to validate_presence_of(:screen_name)}
    it {expect(user).to validate_presence_of(:email)}

  end

  describe 'validar metodos de instancia' do 
     it "verifico que efectivamente tenga una pregunta el usuario" do
        expect(user.questions.count).to eq 1
     end
     it "verifico que el hash del password ande" do 
       passwordHash= user.passwordHash = "hasheame"
        expect(user.valida_password("hasheame")).to eq true
    end

  end

  describe 'validar metodos de clase' do
  end

end