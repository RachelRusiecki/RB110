=begin

Problem:
Input: integer
Output: integer

Rules:
Return sum of all numbers divisible by 3 & 5 below #
Find numbers BELOW input, not including
If sum is below 0, return 0
Multiples of both only counted once

Data Structures:
Array / Iteration?

Algorthim:
Initialize empty array to hold multiples
Initialize array of 1 through input num - 1
Iterate through array
  If the current num is divisible by 3 & 5
    Append to mutliples array
Return sum of multiples

=end

def solution(num)
  multiples = []
  (1...num).to_a.each { |n| multiples << n if (n % 3 == 0) || (n % 5 == 0) }
  multiples.sum
end

p solution(10) == 23
p solution(20) == 78
p solution(200) == 9168
