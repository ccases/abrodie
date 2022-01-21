# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

cca = User.create!({email: "cc@avion.com", password: "123456", password_confirmation: "123456"})
sna = User.create!({email: "sn@avion.com", password: "123456", password_confirmation: "123456"})
pra = User.create!({email: "pr@avion.com", password: "123456", password_confirmation: "123456"})

cc = cca.create_admin!({
  fname: "Carlos",
  lname: "Cases",
  contact_no: "+639170000001"
})
sn = sna.create_admin!({
  fname: "Shaira",
  lname: "Nacino",
  contact_no: "+639170000002"
})
pr = pra.create_admin!({
  fname: "Patrick",
  lname: "Ranchez",
  contact_no: "+639170000003"
})

agency1 = User.create!({email: "agency1@abrodie.com", password: "123456", password_confirmation: "123456"})
# create an agency with license validity 700 days from seeding day
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
  
  specialization: "Cook"
})