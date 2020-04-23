#A Card has two useful bits of information: 
#its face value, and whether it is face-up or face-down. 
#You'll want instance variables to keep track of this information. 
#You'll also want a method to display information about the card: 
#nothing when face-down, or its value when face-up. 
#I also wrote #hide, #reveal, #to_s, and #== methods.
#Common problem: Having issues with #hide and #reveal? Try testing small.



class Card
  attr_reader :value
  def initialize(faceup = true,value)
    @faceup = faceup
    @value = value
  end

  def hide
    @faceup = false 
  end

  def reveal
    @faceup = true
  end
  
  def faceup?
    @faceup
  end

  def to_s
    faceup? ? value.to_s : " "
  end


  def ==(object)
    object.is_a?(self.class) && object.value == value
  end
end

