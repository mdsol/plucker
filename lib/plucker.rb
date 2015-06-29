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
  	steps.push(gets)
  	process_steps_helper(steps)
  end

  def process_user_response
  end

  def process_steps_helper(steps)
  	puts("Thank you. Are there more modified step definitions? (y/n)")
  	user_response = gets
  	if user_response == 'y' || user_response == 'Y' || user_response == 'yes' || user_response == 'Yes' || user_response == 'YES'
  		puts("Enter your modified step definition:")
  		steps.push(gets)
  		process_steps_helper(steps)
  	elsif user_response == 'n' || user_response == 'N' || user_response == 'no' || user_response == 'No' || user_response == 'NO'
  	else

  	end

  end

end

