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
  	results = main_search(features_dir,step_defintions)
  	puts("Done. Here is the smallest sequence of feature files you must run:")
  	puts("")
  	puts(results)
  end

  def process_steps(steps)
  	puts("Thank you. Now enter the heads of your modified step definition(s):") 
  	puts("--This is everything before 'do' and the argument block.--")
  	steps.push(gets)
  	process_steps_helper(steps)
  end

  def process_steps_helper(steps)
  	puts("Are there more modified step definitions? (Y/N)")
  	user_response = gets
  	if user_response == 'y' || user_response == 'Y' || user_response == 'yes' || user_response == 'Yes' || user_response == 'YES'
  		puts("Enter your modified step definition:")
  		steps.push(gets)
  		process_steps_helper(steps)
  	elsif user_response == 'n' || user_response == 'N' || user_response == 'no' || user_response == 'No' || user_response == 'NO'
  	else
  		puts("Sorry that is not a valid response please try again.")
  		puts("")
  		process_steps_helper(steps)
  	end
  end

  def regexp_match(step_definition,step)
  	string_reg = step_definition[step_definition.index('/^')..step_definition.index('$/')+1]
  	string_reg.to_regexp ~= step
  end

  def main_search(features,steps)
  	Dir.chdir(features)
  	feature_files = Dir.glob('**/**/*.feature')
  	steps.each do |step|
  		feature_files.each do |feature_file|
  			File.readlines(feature_file).each do |line|
  				if regexp_match(step,line)
  				else
  				end
  			end
  		end
  	end
  end

end

