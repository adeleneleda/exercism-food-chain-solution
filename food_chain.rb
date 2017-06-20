# Usage:
#   FoodChain.song
# To test:
#  ruby food_chain_test.rb

class FoodChain
  # Array constant to hold the variable subjects in the song
  SUBJECTS = [
    {food: 'fly', line: "I don't know why she swallowed the fly. Perhaps she'll die."},
    {food: 'spider', line: "It wriggled and jiggled and tickled inside her."},
    {food: 'bird', line: "How absurd to swallow a bird!"},
    {food: 'cat', line: "Imagine that, to swallow a cat!"},
    {food: 'dog', line: "What a hog, to swallow a dog!"},
    {food: 'goat', line: "Just opened her throat and swallowed a goat!"},
    {food: 'cow', line: "I don't know how she swallowed a cow!"},
    {food: 'horse', line: "She's dead, of course!"}
  ]

  class << self
    # Generates Food Chain song based on http://exercism.io/exercises/ruby/food-chain/readme
    def song
      lines = []
      previous = []

      SUBJECTS.each_with_index do |subject, index|
        previous << subject[:food]

        lines << swallow(subject)
        lines << generate_midverse(previous.reverse, index)
        lines << generate_fly_line(index)
        lines << "" unless last?(index)
      end

      lines.flatten.compact.join("\n")
    end

    # Generate swallow-and-catch lines given the array of previous subjects
    def generate_midverse(previous_subjects, index)
      line = []
      previous_subjects.each_with_index do |sub, i|
        line << swallow_and_catch(sub, previous_subjects[i+1]) if non_boundary?(index) && i != index
      end

      line
    end

    # Returns normal swallow line given subject (with food and line properties)
    def swallow(subject)
      [
        "I know an old lady who swallowed a #{ subject[:food] }.",
        subject[:line]
      ]
    end

    # Returns swallow-and-catch-line given the main subject (current) and its prey (previous subject)
    def swallow_and_catch(main, prey)
      line = ""
      line += "She swallowed the #{ main } to catch the #{ prey }"
      line += " that wriggled and jiggled and tickled inside her" if prey == "spider"
      line += "."
    end

    # Helper function to return the fly line (which occurs in mid-lines) based on index
    def generate_fly_line(index)
      SUBJECTS[0][:line] if non_boundary?(index)
    end

    # Helper function to check if index is non-boundary (not the first and last of the array)
    def non_boundary?(index)
      !first?(index) && !last?(index)
    end

    # Helper function to check if index is the first in the array
    def first?(index)
      index == 0
    end

    # Helper function to check if index is the last in the SUBJECTS array
    def last?(index)
      index == (SUBJECTS.length - 1)
    end
  end
end