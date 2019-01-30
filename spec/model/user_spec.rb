require "rails_helper"
RSpec.describe User, :type => :model do
  
  let(:user) { FactoryBot.create(:user_with_questions) }
  
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
        expect(user.questions.count).to eq 2
     end
     it "verifico que los metodos de hasheo del paswword ande" do 
       passwordHash= user.passwordHash = "hasheame"
       expect(user.valida_password("hasheame")).to eq true
       passwordHash= user.passwordHash = "hasheame"
       expect(user.valida_password("hashe")).to eq false
     end

     it "verificar genera_token unico" do
       token = user.generate_token
       expect(User.exists?({token: token})).to eq false
     end
  end

  describe 'validar metodos de clase' do
    it "vence token" do
      User.by_token(user.token)
      expect(user.reload.token).to eq nil
    end

    it "no vencer token y verificar que el usuario sea el correspondiente" do
      user.touch
      respond = User.by_token(user.token)
      usercorrespondientetoken = User.find_by(token: respond.token)
      expect(user).to eq usercorrespondientetoken
      expect(user.reload.token).to eq respond.token
    end
   end
end