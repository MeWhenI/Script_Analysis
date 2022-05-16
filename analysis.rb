# Get script from file input
script = `dd`

# Normalize line-break encoding
script.gsub!(2.chr, 10.chr)

# Remove page headings
script.gsub!(/^\d+\.\n|Franklin Latt - CAA/, '')

# Account for the various names used for Deborah throughout the script
script.gsub!(/^THE GIRL|^FEMALE VOICE|^THE WAITRESS|^WAITRESS/, 'DEBORA')

# Define a function to count lines of dialogue per character
def lines_per_character(text)

 # Get all dialogue line headings
 line_headings = text.scan(/^([A-Z ]*[A-Z])(\s\(.*\))?$/).map { |matches| matches[0] }

 # Each unique dialogue heading is a character name
 characters = line_headings.uniq

 # Get line counts per character
 lines_per_character = characters.map { |character| [character, line_headings.count(character)] }.to_h

 return lines_per_character
end

# Get all scene headings
scenes = script.split(/(?=\n\d+ [^\na-z]+\d+\n)/)

# Get count of lines by character in each scene
lines_by_scene = scenes.map { |scene| lines_per_character(scene) }

# Define a list of main characters
main_characters = %w[BABY BATS BUDDY DARLING DEBORA DOC]

# Count total line counts for each main character
lines_per_character = main_characters.map { |character| [character, lines_by_scene.sum{ |scene| scene[character] || 0 }] }.to_h

# Count scenes where each character has spoken dialogue 
scenes_per_character = main_characters.map { |character| [character, lines_by_scene.count{ |scene| scene[character]}] }.to_h

# Format output
puts "Character | Lines of dialogue | Scenes with dialogue",
     "----------+-------------------+---------------------",
     main_characters.map { |character| "%9s | %17d | %20d"%[character, lines_per_character[character], scenes_per_character[character]]}
