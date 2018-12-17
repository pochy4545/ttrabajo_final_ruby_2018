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
  
  describe "callback" do
    it "validar_respuesta incorrecto" do
        expect(Answer.all.count).to eq 0
        answer.question.answer_id = answer.id
        expect(Answer.all.count).to eq 1
        answer.destroy
        expect { Answer.all.count }.not_to change { Answer.all.count }
        expect(Answer.all.count).to eq 1

    end
    it "validar respuesta correcto" do
        expect(Answer.all.count).to eq 0
        answer.question.answer_id = nil
        expect(Answer.all.count).to eq 1
        answer.destroy
        expect { Answer.all.count }.to change { Answer.all.count }.by(0)
        expect(Answer.all.count).to eq 0
    end

    it "validar_estatus incorrecto" do
        expect(Answer.all.count).to eq 0
        answer.question.status = 1
        answer.save
        expect { Answer.all.count }.not_to change { Answer.all.count }  
    end
    
    it "validar_status correcto" do
        expect(Answer.all.count).to eq 0
        answer.question.status = 0
        answer.save
        expect { Answer.all.count }.to change { Answer.all.count }.by(0)
    end

  end

 end