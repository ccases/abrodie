require 'rails_helper'

RSpec.describe Message, type: :model do

  def seed_users
    agency1 = User.create!({email: "agency1@abrodie.com", password: "123456", password_confirmation: "123456"})
    agency = agency1.create_agency!({
      name: "Brodie's Agency",
      verified: true,
      kind: "private",
      license_validity: DateTime.current + 700,
      contact_no: "09165555555",
      address: "2401 Taft Ave, Manila"
    })
    applicant1 = User.create!({email: "applicant1@abrodie.com", password: "123456", password_confirmation: "123456"})
    applicant = applicant1.create_applicant!({
      fname: "Spongebob",
      lname: "Squarepants",
      educational_level: "High school graduate",
      birth_date: DateTime.new(1997, 8, 29),
      specialization: "Cook"
    })
  end

  def create_room
    rm = Room.create(name: "room_#{User.first.id}_#{User.second.id}")
    rm.users << User.first
    rm.users << User.second
  end


  def initialize_tests
    seed_users
    create_room
  end

  context 'when created' do

    let!(:message){Message.new}
    before {initialize_tests}

    it 'does not save on blank body' do
      message.user = User.first
      message.room = Room.first
      message.body = nil
      expect(message).to_not be_valid
    end

    it 'saves with body' do
      message.user = User.first
      message.room = Room.first
      message.body = "Hello world!"
      expect(message).to be_valid
    end
  end
end
# RSpec.describe Article, type: :model do
#   let!(:article) {Article.new}

#   context 'when filled' do
#     it 'does not save with blank name' do
#       article.content = 'Test test'
#       article.author = nil

#       expect(article).to_not be_valid
#       expect(article.errors).to be_present
#       expect(article.errors.to_hash.keys).to include(:author)
#     end
#     it 'does not save with blank title' do
#       article.content = 'Test test'
#       article.title = nil
#       article.author = 'Cardo'

#       expect(article).to_not be_valid
#       expect(article.errors).to be_present
#       expect(article.errors.to_hash.keys).to include(:title)
#     end
#     it 'does not save with no content' do
#       article.content = nil
#       article.title = 'asda'
#       article.author = 'Cardo'

#       expect(article).to_not be_valid
#       expect(article.errors).to be_present
#       expect(article.errors.to_hash.keys).to include(:content)
#     end

#     it 'does not save on duplicate titles' do
#       Article.create(:title => 'Duplicate', :content => 'Content', :author => 'Me')
#       article.title = 'Duplicate'
      
#       expect(article).to_not be_valid
#       expect(article.errors).to be_present
#       expect(article.errors.to_hash.keys).to include(:title)
#     end
#   end

# end