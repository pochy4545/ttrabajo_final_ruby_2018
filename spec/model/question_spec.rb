require "rails_helper"
RSpec.describe Question, :type => :model do
  
  let(:question) { FactoryBot.create(:question_with_answers) }
  let(:question_dos) { FactoryBot.create(:question_with_answers) }  
  let(:question_tres) { FactoryBot.create(:question_with_answers)}
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
  
  describe "tests generales"do
   
   it "verifico que realemente tenga una respuesta asociada"do
        expect(question.answers.count).to eq 1
   end 
   it "borrado de question con respuestas" do
       expect(question.destroy).to eq(false)
   end
 end

  describe "metodos de clase" do
    it "by_pending_first" do
      question_dos.created_at = Date.today
      question_tres.created_at =Date.today
      question_tres.status = true
      question.save
      question_dos.save
      question_tres.save
      respuesta = Question.by_pending_first
      expect(respuesta.count).to be 3
      expect(respuesta.last.id).to be (question_tres.id)
      expect(respuesta.second.id).to be (question_dos.id)
      expect(respuesta.first.id).to be (question.id)
    end
    it "natural_order" do
      question_dos.created_at = Date.today
      question.save
      question_dos.save
      respuesta = Question.natural_order
      expect(respuesta.count).to be 2
      expect(respuesta.second.id).to be (question_dos.id)
      expect(respuesta.first.id).to be (question.id)
    end
 end
end