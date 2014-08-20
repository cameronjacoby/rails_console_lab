class Student < ActiveRecord::Base

  validates :first_name,
    :presence => true,
    :length => {:minimum => 5},
    :format => {:with => /[A-Z][a-z]+/}

  validates :last_name,
    :presence => true,
    :length => {:minimum => 5},
    :format => {:with => /[A-Z][a-z]+/},
    :uniqueness => true

  FORBIDDEN_NAMES = [{:first_name => "Delmer", :last_name => "Reed"},
    {:first_name => "Tim", :last_name => "Licata"},
    {:first_name => "Anil", :last_name => "Bridgpal"},
    {:first_name => "Elie", :last_name => "Schoppik"}]

  validate :name_is_allowed

  def name_is_allowed
    FORBIDDEN_NAMES.each do |name|
      if name.first_name == first_name && name.last_name == last_name
        errors.add(:first_name, :last_name, "this is a restricted name")
      end
    end
  end

end