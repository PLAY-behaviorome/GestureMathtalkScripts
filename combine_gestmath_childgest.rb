## Parameters
windowon = -1000 # Subtracted from onset to expand window earlier.
windowoff = 2000 # Added to offset to expand window later.combined_col_name = "gestmath_childgest"
combined_col_name = "gestmath_childgesture"
combined_codes = %w(gestmath_ordinal childgest_ordinals childgest_p childgest_s childgest_i childgest_c)
forcepointcell = 1 # Mark as 1 if the column to merge should be coded as a point cell, thus you only want onset.

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
if get_column_list().include?('childgesture_clean')
    childgestname = 'childgesture_clean'
else childgestname = 'childgesture'
end

childgest = getVariable(childgestname)
gestmath = getVariable('gesture_mathwords')
gestmath.cells.each do |gmcell|
    #Add window around each point cell
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
    childgest_p_num = 0
    childgest_s_num = 0
    childgest_i_num = 0
    childgest_c_num = 0

    childgest.cells.each do |cgcell|
        cgcellon = cgcell.onset
        if forcepointcell==1
            cgcelloff = cgcell.onset
        else cgcelloff = cgcell.offset
        end
        cellordinal = cgcell.ordinal
        if cgcellon >= gmcellon && cgcelloff <= gmcelloff
            ordinals_list.push(cellordinal)
            if cgcell.gesture_psic == 'p'
                childgest_p_num += 1
            end 
            if cgcell.gesture_psic == 's'
                childgest_s_num += 1
            end
            if cgcell.gesture_psic == 'i'
                childgest_i_num += 1
            end
            if cgcell.gesture_psic == 'c'
                childgest_c_num += 1
            end
        end
    end

    unless ordinals_list.empty?
        olist = ordinals_list.join(' ')
        ncell.change_code('childgest_ordinals', olist)
        ncell.change_code('childgest_p', childgest_p_num)
        ncell.change_code('childgest_s', childgest_s_num)
        ncell.change_code('childgest_i', childgest_i_num)
        ncell.change_code('childgest_c', childgest_c_num)
    else 
        ncell.change_code('childgest_ordinals', '.')
        ncell.change_code('childgest_p', '.')
        ncell.change_code('childgest_s', '.')
        ncell.change_code('childgest_i', '.')
        ncell.change_code('childgest_c', '.')
    end
end 

childgest.cells.each do |cgcell|
    childgest_p_num = 0
    childgest_s_num = 0
    childgest_i_num = 0
    childgest_c_num = 0

    cgcellon = cgcell.onset
    if forcepointcell==1
        cgcelloff = cgcell.onset
    else cgcelloff = cgcell.offset
    end
    childgestonly_cell = gestmath.cells.select{ |g| cgcellon >= (g.onset-windowon) && cgcelloff <= (g.offset+windowoff) }
    if childgestonly_cell.empty?
        #Populate with information from math actions column
        ncell = com_col.new_cell
        if cgcellon >= 0
            ncell.onset = cgcellon
        else
            ncell.onset = 0
        end
        ncell.offset = cgcelloff
        ncell.change_code('gestmath_ordinal', '.')
        ncell.change_code('childgest_ordinals', cgcell.ordinal)
        if cgcell.gesture_psic == 'p'
            childgest_p_num += 1
        end 
        if cgcell.gesture_psic == 's'
            childgest_s_num += 1
        end
        if cgcell.gesture_psic == 'i'
            childgest_i_num += 1
        end
        if cgcell.gesture_psic == 'c'
            childgest_c_num += 1
        end
        ncell.change_code('childgest_p', childgest_p_num)
        ncell.change_code('childgest_s', childgest_s_num)
        ncell.change_code('childgest_i', childgest_i_num)
        ncell.change_code('childgest_c', childgest_c_num)
    end
end


set_column(com_col)
