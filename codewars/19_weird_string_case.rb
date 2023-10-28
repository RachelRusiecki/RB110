=begin

Problem:
Input: string
Output: same string

Rules:
All even indexed (incl 0) will be uppercase; all odd are lowercase
Indices start over at each word (not whole string)
Assume string is only letters and possibly spaces
Words are separated by space

Data Structures:
Index referencing/slicing
Reassignment of elements

Algorithm:
Reassign entire string to downcase version
Iterate through string
  If 1st char...
    uppercase
  If char is space...
    next iteration
  If char follows space or lowercase...
    uppercase
  If char follows uppercase...
    lowercase

=end

def weirdcase(string)
  upcase = true
  (string.length).times do |index|
    if upcase == true
      string[index] = string[index].upcase
    elsif upcase == false
      string[index] = string[index].downcase
    end
    upcase = !upcase
    upcase = true if string[index] == ' '
  end
  string
end

string = 'This is a test'

p weirdcase('This') == 'ThIs'
p weirdcase('is') == 'Is'
p weirdcase(string) == 'ThIs Is A TeSt'
p string

