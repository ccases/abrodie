require 'rails_helper'

RSpec.describe Job, type: :model do

    let!(:job) {Job.new}


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

        job = agency.jobs.create!({
                title:"Engineer",
                location:"Dubai",
                desc:"Work as an Engineer for a construction company",
                employer:"Nice Construction",
                salary:70000
            })
    end


    context 'upon creation' do
        before {seed_users}

        it 'does not save with blank fields' do
            job.title = nil
            job.location = 'Dubai'
            job.employer = 'Nice Construction'
            job.salary = nil
            job.desc = 'Work as an Engineer for a construction company'

            expect(job).to_not be_valid
            expect(job.errors).to be_present

            expect(job.errors.to_hash.keys).to include(:title, :salary)
        end
    end
end