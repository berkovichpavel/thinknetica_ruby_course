ALPHABET = 'abcdefghijklmnopqrstuvwxyz'.freeze
VOWELS = 'aeijoquvy'.freeze
hash = {}

VOWELS.split('').each { |vowel| hash[vowel] = ALPHABET.index(vowel) + 1 }

puts hash.to_s
