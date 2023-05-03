# Write a method that returns one UUID when called with no parameters.

CHARS = %w(a b c d e f 0 1 2 3 4 5 6 7 8 9)

def uuid
  section1 = ''
  section2 = ''
  section3 = ''
  section4 = ''
  section5 = ''
  8.times { section1 << CHARS.sample }
  4.times { section2 << CHARS.sample }
  4.times { section3 << CHARS.sample }
  4.times { section4 << CHARS.sample }
  12.times { section5 << CHARS.sample }
  "#{section1}-#{section2}-#{section3}-#{section4}-#{section5}"
end

p uuid
