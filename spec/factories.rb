FactoryGirl.define do
  factory :party do
    name     "Bart Bloemers"
    email    "bart@badjo.nl"
    password "foobar"
    password_confirmation "foobar"
  end
end