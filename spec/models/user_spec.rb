require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) {User.new}
  let!(:applicant) {user.build_applicant}

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
    job = agency.jobs.create!({
        title: "Cook",
        desc: "Is a Fry Cook",
        location: "Aruba",
        employer: "Company",
        salary: 50000
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


    context 'creating an applicant' do
    before {seed_users}
    
        it 'does not save with blank email' do
            user.email = nil
            user.password = '123456'
            user.password_confirmation = '123456'

            expect(user).to_not be_valid
            expect(user.errors).to be_present
            expect(user.errors.to_hash.keys).to include(:email)
        end

        it 'does not save with a blank password' do 
            user.email = 'applicant1@abrodie.com'
            user.password = nil
            user.password_confirmation = '123456'

            expect(user).to_not be_valid
            expect(user.errors).to be_present
            expect(user.errors.to_hash.keys).to include(:password)
        end

        it 'builds an applicant' do
            user.email = 'applicant12@abrodie.com'
            user.password = '123456'
            user.password_confirmation = '123456'
            applicant.fname = 'stanley'
            applicant.lname = 'pringle'

            expect(user).to be_valid
        end

        it 'applies to a job' do
            user.email = 'applicant123@abrodie.com'
            user.password = '123456'
            user.password_confirmation = '123456'
            applicant.fname = 'stanley'
            applicant.lname = 'pringle'
            user.save

            user.applicant.applications.create({expected_salary: 50000, job_id: Job.first.id})

            expect(user).to be_valid
            expect(applicant.applications.count).to equal(1)
            expect(Job.first.applications.count).to equal(1)
        end
    end
end

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