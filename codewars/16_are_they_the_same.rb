=begin

Problem:
Input: 2 arrays of integers
Output: boolean

Rules:
Return TRUE if 1st array is equal to each element squared in 2nd array
Order does not matter
Arrays can be empty, should return FALSE

Data Structures:
Arrays
Iteration (transformed elements)

Algorithm:
If 2nd array sorted is equal to:
  1st array sorted & each element squared
    Iterate through array1
      Transform elements to squared elements
  Return TRUE
  Otherwise, FALSE

=end

def comp(array1, array2)
  return true if array2.sort == array1.sort.map { |num| num**2 }
  false
end

p comp([121, 144, 19, 161, 19, 144, 19, 11], 
    [121, 14641, 20736, 361, 25921, 361, 20736, 361]) == true

p comp([121, 144, 19, 161, 19, 144, 19, 11], 
    [132, 14641, 20736, 361, 25921, 361, 20736, 361]) == false

p comp([], 
    [132, 14641, 20736, 361, 25921, 361, 20736, 361]) == false
