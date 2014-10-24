require 'pry'
require_relative 'csv_modifier'

class App
  include CsvModifier

  CARNIVORES = ['Carnivore', 'Insectivore', 'Piscivore']

  def initialize(name)
    #@filepath = File.join(APP_ROOT, name)
    @filepath = File.dirname(__FILE__)
    @app_name = name
    #check_file(@filepath)
    @catalog = create_catalog(@filepath, @app_name)
  end

  def load_csv_file(filename)
    #puts "..#{@filepath}/#{@app_name}"
    puts File.exists?("..#{@filepath}/#{@app_name}")
    puts File.exists?("..\/#{filename}")
    #CSV.read("..\/#{filename}", headers: true, header_converters: :symbol)
  end

  def normalize_csv_file(name)
    CsvModifier.normalize_csv_headers(@filepath)
    #need to move all of this to the Catalog class, which will build the catalog instance from this CSV file
    # normalized_filepath_name = CsvModifier.normalized_filepath(catalog_name)
    # #CsvModifier.replace_cell_with_carnivore(normalized_filepath_name)
    # CSV.read(normalized_filepath_name, headers: true, header_converters: :symbol).each do |data|
    #   @dinosaurs << create_dinosaur_entry(data[:name], data)
    # end
  end

  def create_dinosaur_entry(name, attributes)
    Dinosaur.new(name, attributes)
  end

  # def check_file(filepath)
  #   if filepath && File.exists?(filepath)
  #     puts "\nA file was found!"
  #   else
  #     raise IOError, "No file was found."
  #   end
  # end

  def create_catalog(filepath, name)
    Catalog.new(filepath, name)
  end

  def launch!
    normalize_csv_file = normalize_csv_file(file)
    #puts normalize_csv_file

    action = nil
    until action == :back
      print "\n\nWhat would you like to do?\n\n"
      print "1. To list dinosaurs that were bipeds, enter 'Bipeds'.\n"
      print "2. To list dinosaurs that were carnivores, enter 'Carnivores'.\n"
      print "3. To list dinosaurs of a specific period, enter 'period' followed by the period you want, such as 'Period Jurassic'.\n"
      print "4. To list only big or small dinosaurs, enter 'big' or 'small'.\n\n"
      print "To go back import a new CSV file, enter 'back'.\n"
      print "To exit this program, enter 'quit'\n\n"
      print " > "
      user_input = gets.chomp
      formatted_action_arguments = format_user_input(user_input)
      action = do_action(formatted_action_arguments)
    end
  end

  def format_user_input(input)
    action, arguments = input.downcase.strip.split(' ')
  end

  def do_action(action)
    case action[0]
    when 'bipeds'
      list_bipeds
    when 'carnivores'
      list_carnivores
    when 'period'
      list_period(action[1])
    when 'big'
      list_size(action[0])
    when 'small'
      list_size(action[0])
    when 'back'
      return :back
    when 'quit'
      puts "\n\nExiting.\n\n"
      exit!
    else
      "I don't understand. Please enter a valid input."
    end
  end

  def list_bipeds
    bipeds = @catalog.dinosaurs.select { |dinosaur| dinosaur.walking == 'Biped' }
    print "\nThe following dinosaurs are bipeds: \n\n"
    print "Sorry. No bipeds were found" if bipeds.empty?
    bipeds.each do |dinosaur|
      puts "#{dinosaur.name}"
    end
  end

  def list_carnivores
    carnivores = @catalog.dinosaurs.select { |dinosaur| CARNIVORES.include?(dinosaur.diet) }
    print "\nThe following dinosaurs are Carnivores, Insectivores, or Piscivores: \n\n"
    print "Sorry. No carnivores were found" if carnivores.empty?
    carnivores.each do |dinosaur|
      puts "#{dinosaur.name}"
    end
  end

  def list_period(period)
    dinosaurs_in_period = @catalog.dinosaurs.select { |dinosaur| dinosaur.period.downcase =~ /#{period}/ }
    print "\nThe following dinosaurs lived in the #{period.capitalize} period: \n\n"
    print "Sorry. No dinosaurs were found" if dinosaurs_in_period.empty?
    dinosaurs_in_period.each do |dinosaur|
      puts "#{dinosaur.name}"
    end
  end

  def list_size(size)
    dinosaurs_by_size = @catalog.dinosaurs.partition { |dinosaur| dinosaur.big? }
    if size == 'big'
      dinosaur_size_subset = dinosaurs_by_size[0]
    else
      dinosaur_size_subset = dinosaurs_by_size[1].select { |dino| dino.weight_in_lbs }
    end
    print "\nThe following dinosaurs were #{size.capitalize}: \n\n"
    print "Sorry. No dinosaurs were found" if dinosaurs_by_size.empty?
    dinosaur_size_subset.each do |dinosaur|
      puts "#{dinosaur.name}"
    end
  end

end
