require "to_regexp"

module Plucker

  Struct.new("Featuple", :feature, :steps)
  Struct.new("Countuple", :feature, :count)

  $step_definitions = []
  $features_dir = ""

  def main_sequence
    sequence_start
    if $step_definitions.size == 1
      puts("")
      puts("It seems that you only have one modified step definition. Please select from the following two options:")
      single_step
    else
      mode_picker
    end
  end

  def sequence_start
    puts("")
    puts("********----- Hello and welcome to plucker! -----********")
    puts("")
    puts("To begin please enter the path for your features directory:")
    puts("")
    $features_dir = gets.chomp
    puts("")
    process_steps($step_definitions)
  end

  def single_step
    puts("--------------------------------------")
    puts("****-A. Return the shortest feature file that includes the modified step.")
    puts("****-B. Return the feature file with the most occurrences of the modified step.")
    puts("--------------------------------------")
    puts("A or B?")
    user_option = gets.chomp
    puts("")
    if user_option == 'a' || user_option == 'A'
      single_short($features_dir)
    elsif user_option == 'b' || user_option == 'B'
      single_most
    else
      puts("Sorry that is not a valid input.")
      single_step
    end
  end

  def single_short(features)
    result = []
    Dir.chdir(features)
    feature_files = Dir.glob('**/**/*.feature')
  end

  def single_most
  end

  def shortest_sequence
    results = process_results(main_search_seq($features_dir))
    puts("Done. Here is the smallest sequence of feature files you must run:")
    puts("")
    results.each do |result|
      puts result[:feature]
    end
    puts("")
  end

  def custom_file
  end

  def mode_picker
    puts("Please select your preferred option.")
    puts("--------------------------------------")
    puts("****-A. Return a list of the smallest sequence of full feature files possible to test all modified step definitions.")
    puts("****-B. Create an encompassing custom feature file consisting of existing scenarios that test all modified step definitions.")
    puts("--------------------------------------")
    puts("A or B?")
    user_option = gets.chomp
    puts("")
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
    puts("Thank you. Now enter the head(s) of your modified step definition(s):") 
    puts("--This is the first line of the definition which defines it--")
    puts("")
    steps.push(gets.chomp)
    puts("")
    process_steps_helper(steps)
  end

  def process_steps_helper(steps)
    puts("Are there more modified step definitions? (Y/N)")
    user_response = gets.chomp
    puts("")
    if user_response == 'y' || user_response == 'Y' || user_response == 'yes' || user_response == 'Yes' || user_response == 'YES'
      puts("Enter your modified step definition:")
      puts("")
      steps.push(gets.chomp)
      puts("")
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
    string_temp_one = step.lstrip.chomp
    string_step = ""
    if string_temp_one.start_with?('Given')
      string_step = string_temp_one[6..string_temp_one.size-1]
    elsif string_temp_one.start_with?('Then') || string_temp_one.start_with?('When')
      string_step = string_temp_one[5..string_temp_one.size-1]
    elsif string_temp_one.start_with?('And') || string_temp_one.start_with?('But')
      string_step = string_temp_one[4..string_temp_one.size-1]
    else
    end
    my_reg = string_reg.to_regexp
    my_reg =~ string_step    
  end

  def main_search_single(features,steps)
  end

  def main_search_seq(features)
    result = []
    Dir.chdir(features)
    feature_files = Dir.glob('**/**/*.feature')
    feature_files.each do |feature_file|
      curr_featuple = Struct::Featuple.new(File.absolute_path(feature_file),[])
      $step_definitions.each do |step|
        File.readlines(feature_file).each do |line|
          if regexp_match(step,line)
            curr_featuple[:steps].push(step) 
            break
          end
        end
      end
      result.push(curr_featuple) if curr_featuple[:steps].size >= 1
    end
    result
  end

  def main_search_custom(features)
  end

  def greedy_sequence(result)
    final_res = []
    while result.size >= 1
      temp = result[result.size-1]
      final_res.push(result.pop)
      result.each do |featuple|
        temp[:steps].each do |step|
          featuple[:steps].delete(step)
        end
      end
      result.delete_if{|feat| feat[:steps].size == 0}
      result.sort!{| a , b | a[:steps].size <=> b[:steps].size}
    end
    final_res
  end

  def process_results(result)
    result.sort!{| a , b | a[:steps].size <=> b[:steps].size}
    greedy_sequence(result)
  end

end

