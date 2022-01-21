class Application < ApplicationRecord
  belongs_to :applicant
  belongs_to :job
end
