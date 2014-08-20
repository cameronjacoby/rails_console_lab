## Console Lab

For this lab, we'd like you to strengthen your Rails console skills. This lab is going to be very familiar to the SQL lab, where we'll ask you to create a model and then write out the console commands you would use to execute these queries

### To Start

* Create a model called Student, that has a first_name, last_name and age

```
rails generate model Student first_name:string last_name:string age:integer
```
* Don't forget to run your migrations

```
rake db:migrate
```

### Tasks to create

* Using the new/save syntax, create a student, first and last name and an age

```
new_student = Student.new
new_student.first_name = "Cameron"
new_student.last_name = "Jacoby"
new_student.age = 24
```
* Save the student to the database

```
new_student.save
```
* Using the find/set/save syntax update the student's first name to taco

```
found_student = Student.find_by_id(1)
found_student.first_name = "Taco"
found_student.save
```
* Delete the student (where first_name is taco)

```
taco = Student.find_by_first_name("Taco")
taco.destroy
```
* Validate that every Student's last name is unique

```
validates_uniqueness_of :last_name
```
* Validate that every Student has a first and last name that is longer than 4 characters

```
validates_length_of :first_name, :minimum => 5
validates_length_of :last_name, :minimum => 5
```
* Validate that every first and last name cannot be empty

```
validates_presence_of :first_name
validates_presence_of :last_name
```
* Combine all of these individual validations into one validation (using validate and a hash)

```
validates :first_name,
  :presence => true,
  :length => {:minimum => 5}

validates :last_name,
  :presence => true,
  :length => {:minimum => 5},
  :uniqueness => true
```
* Using the create syntax create a student named John Doe who is 33 years old

```
john = Student.create(:first_name => "John", :last_name => "Doe", :age => 33)
```
* Show if this new student entry is valid

```
john.valid?
```
* Show the number of errors for this student instance

```
john.errors.size
```
* In one command, Change John Doe's name to Jonathan Doesmith

```
john.update_attributes(:first_name => "Jonathan", :last_name => "Doesmith")
```
* Clear the errors array

```
john.errors.clear
```
* Save Jonathan Doesmith

```
john.save
```
* Find all of the Students

```
Student.all
```
* Find the student with an ID of 128 and if it does not exist, make sure it returns nil and not an error

```
Student.find_by_id(128)
```
* Find the first student in the table

```
Student.first
```
* Find the last student in the table

```
Student.last
```
* Find the student with the last name of Doesmith

```
Student.find_by_last_name("Doesmith")
```
* Find all of the students and limit the search to 5 students, starting with the 2nd student and finally, order the students in alphabetical order

```
Student.all.order(:first_name).offset(1).limit(5)
```
* Delete Jonathan Doesmith

```
Student.find_by_last_name("Doesmith").destroy
```

### Bonus

* Use the validates_format_of and regex to only validate names that consist of letters (no numbers or symbols) and start with a capital letter

```
:format => {:with => /\A[A-Z][a-zA-Z]+\z/}
```

* Write a custom validation to ensure that no one named Delmer Reed, Tim Licata, Anil Bridgpal or Elie Schoppik is included in the students table

```
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
```
