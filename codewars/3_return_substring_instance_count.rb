=begin

Problem:
Input: 2 strings (full text, search criteria)
Output: integer (# of occurences of search text)

Rules:
Return # of times search text is found in full text
No overlap, "aaa" - "aa" occurs once only

Data Structures:
strings
Iteration
Array?

Algorithm:
Initialize empty string to hold chars
Initialize empty array to hold sub-strings
Iterate through each char of full
  Iterate through each char of search
    If current full letter is equal to current char of search append it to new string
      If next index of each is the same, append to string until sequence doesn't match
      Append sub-string to array
      Delete sub-string from string
Return size of array

=end

def solution(full_text, search_text)
  full_text.delete("^#{search_text}").size / search_text.size
end

p solution('abcdeb','b') == 2
p solution('abcdeb', 'a') == 1
p solution('abbc', 'bb') == 1
