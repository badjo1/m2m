FactoryGirl.define do
  factory :party do
    name     "Bart Bloemers"
    email    "user@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end