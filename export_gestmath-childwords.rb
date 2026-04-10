## Params
## CHANGE THIS SECTION AS NEEDED
input_folder = '~/Desktop/GestureMath/GestureMath-Combine3'
output_file = '~/Desktop/export_childwords.tsv' # change to .csv for comma separated value file
delimiter = "\t" # separator between data, "," for comma

# Enter names of relevant columns
id_col = "id"
par_gestmath_col = "gesture_mathwords"
child_col = "gestmath_childwords" #Name of child column to export

# Enter codes from the ID column in the order that matches the header.
id_order = ["id","parent","activity"] #separete codes by commas ["studyname","subjnum","testdate"]
gestmath_order = ["ordinal","pgest_ordinal","pgesture","ordinals_en","words_en","number_en","function_en","order_en","sing_ref_en","shapes_en","mag_comp_en","loc_dir_en","or_en","deictics_en","feat_prop_en","time_en","false_en",
"ordinals_sp","words_sp","number_sp","function_sp","order_sp","sing_ref_sp","shapes_sp","mag_comp_sp","loc_dir_sp","or_sp","deictics_sp","feat_prop_sp","time_sp","false_sp","gestonly_notransc"]
child_col_order = ["onset","offset","ordinals_en","words_en","number_en","function_en","order_en","sing_ref_en","shapes_en","mag_comp_en","loc_dir_en","or_en","deictics_en","feat_prop_en","time_en","false_en",
"ordinals_sp","words_sp","number_sp","function_sp","order_sp","sing_ref_sp","shapes_sp","mag_comp_sp","loc_dir_sp","or_sp","deictics_sp","feat_prop_sp","time_sp","false_sp"]

chi_col_header = %w[chi_ordinal chi_onset chi_offset chi_ordinals_en chi_words_en chi_number_en chi_function_en chi_order_en chi_sing_ref_en chi_shapes_en chi_mag_comp_en chi_loc_dir_en chi_or_en chi_deictics_en chi_feat_prop_en chi_time_en chi_false_en
chi_ordinals_sp chi_words_sp chi_number_sp chi_function_sp chi_order_sp chi_sing_ref_sp chi_shapes_sp chi_mag_comp_sp chi_loc_dir_sp chi_or_sp chi_deictics_sp chi_feat_prop_sp chi_time_sp chi_false_sp]
par_col_header = %w[par_gestmath_ordinal par_gest_ordinal par_gesture par_ordinals_en par_words_en par_number_en par_function_en par_order_en par_sing_ref_en par_shapes_en par_mag_comp_en par_loc_dir_en par_or_en par_deictics_en par_feat_prop_en par_time_en par_false_en
par_ordinals_sp par_words_sp par_number_sp par_function_sp par_order_sp par_sing_ref_sp par_shapes_sp par_mag_comp_sp par_loc_dir_sp par_or_sp par_deictics_sp par_feat_prop_sp par_time_sp par_false_sp gestonly_notransc]

# Enter the header labels exactly as you want them to appear on the export spreadsheet.
print_header = true #change to false to remove header, true to keep header

## Body
## DO NOT CHANGE ANYTHING BELOW THIS LINE
begin
  # Init an empty list to store lines of data
  data = []

  # Put the header together and add as first item to our data.
  if(print_header)
   header = id_order + chi_col_header + par_col_header
   data << header.join(delimiter)
  end
  
  inpath = File.expand_path(input_folder)
  infiles = get_datavyu_files_from(inpath)
  infiles.each do |infile|
  puts "Working on #{infile}..."

  # Load the spreadsheet
  $db, $pj = load_db(File.join(inpath, infile))


  # Get the variables we want to print from the loaded file
  id = getVariable(id_col)
  childcol = getVariable(child_col)
  gestmath = getVariable(par_gestmath_col)
  
  chi_ordinal = 0

  # Loop over the cells in ID
  for idcell in id.cells
    # Get id codes frome this id cell
    idCodes = idcell.getArgs(*id_order)
    childCodes = []

    # Loop over the cells in child behavior column that are contained by this idcell
    for childcell in childcol.cells.select{ |c| idcell.overlaps_cell(c) }
        childCodes = childcell.getArgs(*child_col_order)
        chi_ordinal += 1
        gmCodes = []
        
        unless childcell.gestmath_ordinal == "."
            gestmath.cells.each do |gmcell|
                if childcell.gestmath_ordinal.to_i == gmcell.ordinal
                gmCodes = gmcell.getArgs(*gestmath_order)
                end
            end
        end 

        

    # Combine codes from each column into one list
        row = [idCodes,chi_ordinal,childCodes,gmCodes]

    # Join the list together using delimiter and add into data
        data << row.join(delimiter)
    end
  end
 end

  # Open the file we want to print the output to
  # ~ is a shortcut for the current user's home directory, ~/Desktop/ will put it
  # on your desktop
  output_file = File.new(File.expand_path(output_file), 'w+')

  # Write out data to file
  puts "Writing to file..."
  output_file.puts data
  output_file.close

  puts "FINISHED"
end