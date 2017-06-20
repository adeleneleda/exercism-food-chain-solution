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

  def generate_song
    previous = []
    
    SUBJECTS.each_with_index do |subject, index|
      swallow(subject)
      previous << subject[:food]
      generate_midverse(previous.reverse, index)
      generate_fly_line(index)
      puts ""
    end
  end

  def generate_midverse(previous_subjects, index)
    previous_subjects.each_with_index do |sub, i|
      swallow_and_catch(sub, previous_subjects[i+1]) if non_boundary?(index) && i != index
    end
  end

  def generate_fly_line(index)
    puts SUBJECTS[0][:line] if non_boundary?(index)
  end

  def swallow(subject)
    puts "I know an old lady who swallowed a #{ subject[:food] }."
    puts subject[:line]
  end

  def swallow_and_catch(main, prey)
    print "She swallowed the #{ main } to catch the #{ prey }"
    print " that wriggled and jiggled and tickled inside her" if prey == "spider"
    puts "."
  end

  def non_boundary?(index)
    !_first?(index) && !_last?(index)
  end

  def _first?(index)
    index == 0
  end

  def _last?(index)
    index == (SUBJECTS.length - 1)
  end
end

food_chain = FoodChain.new
food_chain.generate_song