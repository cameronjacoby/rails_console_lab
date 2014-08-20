class Student < ActiveRecord::Base
  
  validates :first_name,
    :presence => true,
    :length => {:minimum => 5}

  validates :last_name,
    :presence => true,
    :length => {:minimum => 5},
    :uniqueness => true
end