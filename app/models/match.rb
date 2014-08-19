class Match < ActiveRecord::Base

  # For relation
  belongs_to :home,  class_name: "Team"
  belongs_to :guest, class_name: "Team"
  has_many   :goals
  
end
