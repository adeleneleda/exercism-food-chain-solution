"""
food_chain = FoodChain.new
food_chain.generate_song

"""
class FoodChain
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

  class Subject
    attr_accessor :food, :line

    def initialize(food, line)
      @food = food
      @line = line
    end
  end

  class << self
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

    def generate_midverse(previous_subjects, index)
      line = []
      previous_subjects.each_with_index do |sub, i|
        line << swallow_and_catch(sub, previous_subjects[i+1]) if non_boundary?(index) && i != index
      end

      line
    end

    def generate_fly_line(index)
      SUBJECTS[0][:line] if non_boundary?(index)
    end

    def swallow(subject)
      line = [
                "I know an old lady who swallowed a #{ subject[:food] }.",
                subject[:line]
              ]
    end

    def swallow_and_catch(main, prey)
      line = ""
      line += "She swallowed the #{ main } to catch the #{ prey }"
      line += " that wriggled and jiggled and tickled inside her" if prey == "spider"
      line += "."
    end

    def non_boundary?(index)
      !first?(index) && !last?(index)
    end

    def first?(index)
      index == 0
    end

    def last?(index)
      index == (SUBJECTS.length - 1)
    end
  end
end