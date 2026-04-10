## Parameters
windowon = -1000 # Subtracted from onset to expand window earlier.
windowoff = 2000 # Added to offset to expand window earlier.
combined_col_name = "gestmath_mathaction"
combined_codes = %w(gestmath_ordinal mathaction_ordinals mathaction_p)
forcepointcell = 1 # Mark as 1 if the column to merge should be coded as a point cell, thus you only want onset; otherwise as 0.

## Body
require 'Datavyu_API.rb'
    
# Clear out old column for testing purposes.
if get_column_list().include?(combined_col_name)
    delete_column(combined_col_name)
end
  
# Make new combined column with name and codes from parameter section
com_col = new_column(combined_col_name, *combined_codes)

# Retrieve primary gesture coding
#Pull gesture from clean column if available
if get_column_list().include?('mathaction_clean')
    mathactionname = 'mathaction_clean'
else mathactionname = 'mathaction'
end

mathaction = getVariable(mathactionname)
gestmath = getVariable('gesture_mathwords')
gestmath.cells.each do |gmcell|
    #Add window around each cell
    gmcellon = gmcell.onset - windowon 
    gmcelloff = gmcell.offset + windowoff 

    ncell = com_col.new_cell
    if gmcellon >= 0
        ncell.onset = gmcellon
    else
        ncell.onset = 0
    end
    ncell.offset = gmcelloff
    ncell.change_code('gestmath_ordinal', gmcell.ordinal)

    ordinals_list = Array.new
    mathaction_p_num = 0

    mathaction.cells.each do |macell|
        macellon = macell.onset
        if forcepointcell==1
            macelloff = macell.onset
        else macelloff = macell.offset
        end
        cellordinal = macell.ordinal
        if macellon >= gmcellon && macelloff <= gmcelloff
            ordinals_list.push(cellordinal)
            if macell.mathaction == 'p'
                mathaction_p_num += 1
            end 
        end
    end
    
    unless ordinals_list.empty?
        olist = ordinals_list.join(' ')
        ncell.change_code('mathaction_ordinals', olist)
        ncell.change_code('mathaction_p', mathaction_p_num)
    else 
        ncell.change_code('mathaction_ordinals', '.')
        ncell.change_code('mathaction_p', '.')
    end
end 

mathaction.cells.each do |macell|
    mathaction_p_num = 0

    macellon = macell.onset
    if forcepointcell==1
        macelloff = macell.onset
    else macelloff = macell.offset
    end
    mathactonly_cell = gestmath.cells.select{ |g| macellon >= (g.onset-windowon) && macelloff <= (g.offset+windowoff) }
    if mathactonly_cell.empty?
        #Populate with information from math actions column
        ncell = com_col.new_cell
        if macellon >= 0
            ncell.onset = macellon
        else
            ncell.onset = 0
        end
        ncell.offset = macelloff
        ncell.change_code('gestmath_ordinal', '.')
        ncell.change_code('mathaction_ordinals', macell.ordinal)
        if macell.mathaction == 'p'
            mathaction_p_num += 1
        end 
        ncell.change_code('mathaction_p', mathaction_p_num)
    end
end




set_column(com_col)
