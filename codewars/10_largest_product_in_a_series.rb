=begin

Problem:
Input: string of digits
Output: integer

Rules:
Return largest product (multiplying) of 5 consecutive digits
Assume all strings are more than 5 digits

Data Structures:
Substrings / Subarrays
Index slicing

Algorithm:
Find all 5 digit subarrays
  Initialize empty array to hold subarrays
  Initialize arr variable
    set to array of digits converted to integers
      Iterate through array, transform strings to integers
  Iterate through array w/ index (string length - 4 times)
    Append array range from current index through + 4
  Return array of all 5 digit subarrays

Find the greatest product of the subarrays
  find greatest subarray by product
Return product

=end

def greatest_product(digits)
  subarrays = []
  integers = digits.chars.map(&:to_i)
  (digits.size - 4).times { |idx| subarrays << integers[idx..(idx + 4)] }
  subarrays.max_by { |subarray| subarray.inject(:*) }.inject(:*)
end

p greatest_product("123834539327238239583") == 3240
p greatest_product("395831238345393272382") == 3240
p greatest_product("92494737828244222221111111532909999") == 5292
p greatest_product("02494037820244202221011110532909999") == 0
