require "to_regexp"

module Plucker

  Struct.new("featuple_one", :feature, :steps)
  Struct.new("featuple_two", :feature, :count)

  step_definitions = []
  features_dir = ""

  def main_sequence
    sequence_start
    if step_definitions.size == 1
      single_step
    else
      mode_picker
    end
  end

  def sequence_start
    puts("")
    puts("****-Hello and welcome to plucker!-****")
    puts("")
    puts("To begin please enter the path for your features directory:")
    features_dir = gets
    process_steps(step_definitions)
  end

  def single_step
  end

  def shortest_sequence
    results = process_results(main_search_seq(features_dir,step_defintions))
    puts("Done. Here is the smallest sequence of feature files you must run:")
    puts("")
    puts(results)
  end

  def custom_file
  end

  def mode_picker
    puts("Please select your preferred option.")
    puts("---------------------")
    puts("****-A. Return a list of the smallest sequence of full feature files possible to test all modified step definitions.")
    puts("****-B. Create an encompassing custom feature file consisting of existing scenarios that test all modified step definitions.")
    puts("---------------------")
    puts("A or B?")
    user_option = gets
    #if user_option == 'a' || user_option == 'A'
      shortest_sequence
    #elsif user_option == 'b' || user_option == 'B'
    #  custom_file
    #else
    #  puts("Sorry that is not a valid input.")
    #  mode_picker
    #end
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

  def main_search_single(features,steps)
  end

  def main_search_seq(features,steps)
    result = []
  	Dir.chdir(features)
  	feature_files = Dir.glob('**/**/*.feature')
  	feature_files.each do |feature_file|
      curr_featuple = Struct::featuple_one.new(<insert code to get file name from file here>,[])
  		steps.each do |step|
  			File.readlines(feature_file).each do |line|
          if regexp_match(step,line)
            curr_featuple[:steps].push(step) 
            break
          end
  			end
  		end
      result.push(featuple) if curr_featuple[:steps].size >= 1
  	end
    result
  end

  def main_search_custom(features,steps)
  end

  def greedy_sequence(result)
    final_res = []
    while result.size >= 1
      temp = result[result.size-1]
      final_res.push(result.pop)
      temp[:steps].each do |step|
        result.each do |featuple|
        end
      end
    end
  end

  def process_results(result)
    result.sort{|x,y| x[:steps].size <=> y[:steps].size}
    greedy_sequence(result)
  end

end

