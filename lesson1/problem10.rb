# Given the munsters hash below

munsters = {
  'Herman' => { 'age' => 32, 'gender' => 'male' },
  'Lily' => { 'age' => 30, 'gender' => 'female' },
  'Grandpa' => { 'age' => 402, 'gender' => 'male' },
  'Eddie' => { 'age' => 10, 'gender' => 'male' },
  'Marilyn' => { 'age' => 23, 'gender' => 'female' }
}

# Modify the hash so each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior).

munsters.each do |_, hash|
  case hash['age']
  when (..17) then hash['age_group'] = 'kid'
  when (18..64) then hash['age_group'] = 'adult'
  else
    hash['age_group'] = 'senior'
  end
end

p munsters
