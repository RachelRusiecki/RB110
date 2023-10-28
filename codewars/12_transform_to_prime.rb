=begin

Problem:
Input: array of integers
Output: integer (size of list)

Rules:
Return min # of digits to be listed so that sum of list equals closest prime #
arr will container at least 2 elements
Only positive integers
Could have repeating elements

Data Structures:
Arrays
Iteration

Algorithm:
Find sum of array
  Assign sum to new varable

Prime?
  Iterate through 2 through sum - 1
    If sum divided by current num has remainder of 0, then not prime (FALSE)
    Otherwise, return TRUE

Find next prime #
  Initialize 2nd sum (prime) variable, set to sum
    Check if prime
    If not, increase prime by 1
Once prime is found...

Return difference
  Subtract sum from prime

=end

def prime?(num)
  2.upto(num - 1) { |n| return false if num % n == 0 }
  true
end

def minimum_number(arr)
  sum = arr.sum
  prime = sum
  prime += 1 until prime?(prime)
  prime - sum
end

p minimum_number([3,1,2]) == 1
p minimum_number([5,2]) == 0
p minimum_number([1,1,1]) == 0
p minimum_number([2,12,8,4,6]) == 5
p minimum_number([50,39,49,6,17,28]) == 2
