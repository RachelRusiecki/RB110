=begin

Complete the function scramble(str1, str2) that returns true if a portion of 
str1 characters can be rearranged to match str2, otherwise returns false.

Only lower case letters will be used (a-z). No punctuation or digits will be included.

Problem:
Input: 2 strings
Output: boolean

Rules:
Determine if 1st input string's characters are all included in 2nd
If yes, return TRUE, if not, return FALSE
Only lowercase letters
No punction or digits included

Implicit Rules:
Not all letters need to be used from 1st string
Letter from 1st string can only be used once

Data Structures:
Array, iteration

Algorithm:
Iterate through 2nd string
Check if each letter is included in 1st string
  Compare current letter of the 2nd string to 1st string (icluded in 1st string)
If it is...delete the letter from 1st string
Return FALSE any time letter is not included in 1st string
Return TRUE

=end

def scramble(s1, s2)
  s2.each_char do |letter|
    return false unless s2.count(letter) <= s1.count(letter)
  end
  true
end

p scramble('rkqodlw', 'world') == true
p scramble('cedewaraaossoqqyt', 'codewars') == true
p scramble('katas', 'steak') == false
p scramble('mcbxefsksmbxdoxwqo', 'fqkoxsbcxxemwmdbs') == true
