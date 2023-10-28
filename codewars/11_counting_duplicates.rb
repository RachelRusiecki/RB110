=begin

Problem:
Input: string
Output: integer

Rules:
Return count of repeating chars
  Case insensitive, b & B count as repeats
No punction, spaces, etc

Implict Rules:
If empty string, return 0
Repeating char can have any # of repeats greater than 1

Data Structures:
Iteration

Algorithm:
Return 0 if input string is empty
Initialize array of all lowercase letters & 0-9
Initialize counter variable, set it 0
Iterate through alphabet
  Find count of each lowercase char
    If count > 1
      Increase counter by 1
Return counter

=end

def duplicate_count(text)
  return 0 if text.empty?
  counter = 0
  (('a'..'z').to_a + ('0'..'9').to_a).each do |letter|
    counter += 1 if text.downcase.count(letter) > 1
  end
  counter
end

p duplicate_count("") == 0
p duplicate_count("abcde") == 0
p duplicate_count("abcdeaa") == 1
p duplicate_count("abcdeaB") == 2
p duplicate_count("Indivisibilities") == 2
