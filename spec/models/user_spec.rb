require 'rails_helper'

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