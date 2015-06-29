require "to_regexp"

module Plucker

  def main_sequence

  	step_definitions = []

  	puts("")
  	puts("****-Hello and welcome to plucker!-****")
  	puts("")
  	puts("To begin please enter the path for your features directory:")
  	features_dir = gets
  	process_steps(step_definitions)

  end

  def process_steps(steps)
  	puts("Thank you. Now enter the heads of your modified step definition(s):") 
  	puts("--This is everything before 'do' and the argument block.--")
  end

  def process_steps_helper(steps)

  end

end

