# Get script from file input
script = `dd`

# Normalize line-break encoding
script.gsub!(2.chr,10.chr)

# Remove page headings
script.gsub!(/^\d+\.\n|Franklin Latt - CAA/,'')

# Account for the various names used for Deborah throughout the script
script.gsub!(/^THE GIRL|^FEMALE VOICE|^THE WAITRESS|^WAITRESS/,'DEBORA')

# Get all dialogue line headings
line_headings = script.scan(/^([A-Z ]*[A-Z])(\s\(.*\))?$/).map { |matches| matches[0] }

# Each unique dialogue heading is a character name
characters = line_headings.uniq

# Get line counts per character
lines_per_character = characters.map { |character| [character, line_headings.count(character)]}.to_h

# Get all scene headings
scenes = script.split(/(?=\n\d+ [^\na-z]+\d+\n)/)

puts lines_per_character
