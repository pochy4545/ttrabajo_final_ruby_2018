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
       passwordHash= user.password_hash = "hasheame"
       expect(user.valida_password("hasheame")).to eq true
       passwordHash= user.password_hash = "hasheame"
       expect(user.valida_password("hashe")).to eq false
     end

  end
  describe 'generando el token' do
    let!(:users) { FactoryBot.create_list(:user, 10) }
    
    before { allow(SecureRandom).to receive(:hex).and_return('abcd1234') }
    
    it 'debe asignar el token generado' do
      expect(users.pluck(:token)).not_to include('abcd1234')
      expect(User.exists?({token: 'abcd1234'})).to eq false
      expect(users.first.generate_token).to eq 'abcd1234'
    end

  end
  describe 'actualizando el token' do
  let!(:users) { FactoryBot.create_list(:user, 10, updated_at: Date.yesterday) }

  it 'debe actualizar todos los que estén vencidos' do
    user = User.by_token(users.first.token)
    users.map(&:reload)
    expect(users.pluck(:token)).to all(be nil)     
    expect(users.map { |user| user.reload.updated_at.to_date }).to all(eq DateTime.now.to_date)
  end
end

  describe 'validar metodos de clase' do
    it "no vencer token y verificar que el usuario sea el correspondiente" do
      user.touch
      respond = User.by_token(user.token)
      usercorrespondientetoken = User.find_by(token: respond.token)
      expect(user).to eq usercorrespondientetoken
      expect(user.reload.token).to eq respond.token
    end
   end
end