## Parameters
windowon = -1000 # Subtracted from onset to expand window earlier.
windowoff = 2000 # Added to offset to expand window earlier.combined_col_name = "gestmath_childgest"
combined_col_name = "gestmath_childwords"
combined_codes = %w(gestmath_ordinal ordinals_en words_en number_en function_en order_en sing_ref_en shapes_en mag_comp_en loc_dir_en or_en deictics_en feat_prop_en time_en false_en
ordinals_sp words_sp number_sp function_sp order_sp sing_ref_sp shapes_sp mag_comp_sp loc_dir_sp or_sp deictics_sp feat_prop_sp time_sp false_sp )
forcepointcell = 1 # Mark as 1 if the column to merge should be coded as a point cell, thus you only want onset.

## Body
require 'Datavyu_API.rb'
    
# Clear out old column for testing purposes.
if get_column_list().include?(combined_col_name)
    delete_column(combined_col_name)
end
  
# Make new combined column with name and codes from parameter section
com_col = new_column(combined_col_name, *combined_codes)

if get_column_list().include?('child_eng_mathwords')
    mathcat_en = getVariable('child_eng_categories')
    words_en = getVariable('child_eng_mathwords')
end
if get_column_list().include?('child_spa_mathwords')
    mathcat_sp = getVariable('child_spa_categories')
    words_sp = getVariable('child_spa_mathwords')
end
gestmath = getVariable('gesture_mathwords')

# Retrieve child mathwords in eng

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
    
    words_en_list = Array.new
    ordinals_en_list = Array.new
    number_en_num = 0
    function_en_num = 0
    order_en_num = 0
    sing_ref_en_num = 0
    shapes_en_num = 0
    mag_comp_en_num = 0
    loc_dir_en_num = 0
    or_en_num = 0
    deictics_en_num = 0
    feat_prop_en_num = 0
    time_en_num = 0
    false_en_num = 0

    if get_column_list().include?('child_eng_mathwords')  
    words_en.cells.each do |wcell|
        cellwords = wcell.words
        wcellwords = cellwords.split(', ')
        cellordinals = wcell.ordinal

        if wcell.onset >= gmcellon && wcell.onset <= gmcelloff
            words_en_list.push(wcellwords)
            ordinals_en_list.push(cellordinals)
            mathcat_en.cells.each do |mcell|
                if mcell.ordinal == wcell.ordinal 
                    number_en_num += mcell.number.to_i
                    function_en_num += mcell.function.to_i
                    order_en_num += mcell.order.to_i
                    sing_ref_en_num += mcell.sing_ref.to_i
                    shapes_en_num += mcell.shapes.to_i
                    mag_comp_en_num += mcell.mag_comp.to_i
                    loc_dir_en_num += mcell.loc_dir.to_i
                    or_en_num += mcell.or.to_i
                    deictics_en_num += mcell.deictics.to_i 
                    feat_prop_en_num += mcell.feat_prop.to_i 
                    time_en_num += mcell.time.to_i 
                    false_en_num += mcell.false.to_i 
                end
            end
        end
    end
    end

    unless words_en_list.empty?
        wlist_en = words_en_list.join(' ')
        olist_en = ordinals_en_list.join(' ')
        ncell.change_code('words_en', wlist_en)
        ncell.change_code('ordinals_en', olist_en)
        ncell.change_code('number_en', number_en_num)
        ncell.change_code('function_en', function_en_num)
        ncell.change_code('order_en', order_en_num)
        ncell.change_code('sing_ref_en', sing_ref_en_num)
        ncell.change_code('shapes_en', shapes_en_num)
        ncell.change_code('mag_comp_en', mag_comp_en_num)
        ncell.change_code('loc_dir_en', loc_dir_en_num)
        ncell.change_code('or_en', or_en_num)
        ncell.change_code('deictics_en', deictics_en_num)
        ncell.change_code('feat_prop_en', feat_prop_en_num)
        ncell.change_code('time_en', time_en_num)
        ncell.change_code('false_en', false_en_num)
    else 
        ncell.change_code('words_en', '.')
        ncell.change_code('ordinals_en', '.')
        ncell.change_code('number_en', '.')
        ncell.change_code('function_en', '.')
        ncell.change_code('order_en', '.')
        ncell.change_code('sing_ref_en', '.')
        ncell.change_code('shapes_en', '.')
        ncell.change_code('mag_comp_en', '.')
        ncell.change_code('loc_dir_en', '.')
        ncell.change_code('or_en', '.')
        ncell.change_code('deictics_en', '.')
        ncell.change_code('feat_prop_en', '.')
        ncell.change_code('time_en', '.')
        ncell.change_code('false_en', '.')
    end

    words_sp_list = Array.new
    ordinals_sp_list = Array.new
    number_sp_num = 0
    function_sp_num = 0
    order_sp_num = 0
    sing_ref_sp_num = 0
    shapes_sp_num = 0
    mag_comp_sp_num = 0
    loc_dir_sp_num = 0
    or_sp_num = 0
    deictics_sp_num = 0
    feat_prop_sp_num = 0
    time_sp_num = 0
    false_sp_num = 0

    if get_column_list().include?('child_spa_mathwords')  
    words_sp.cells.each do |wcell|
        cellwords = wcell.words
        wcellwords = cellwords.split(', ')
        cellordinals = wcell.ordinal

        if wcell.onset >= gmcellon && wcell.onset <= gmcelloff
            words_sp_list.push(wcellwords)
            ordinals_sp_list.push(cellordinals)
            mathcat_sp.cells.each do |mcell|
                if mcell.ordinal == wcell.ordinal 
                    number_sp_num += mcell.number.to_i
                    function_sp_num += mcell.function.to_i
                    order_sp_num += mcell.order.to_i
                    sing_ref_sp_num += mcell.sing_ref.to_i
                    shapes_sp_num += mcell.shapes.to_i
                    mag_comp_sp_num += mcell.mag_comp.to_i
                    loc_dir_sp_num += mcell.loc_dir.to_i
                    or_sp_num += mcell.or.to_i
                    deictics_sp_num += mcell.deictics.to_i 
                    feat_prop_sp_num += mcell.feat_prop.to_i 
                    time_sp_num += mcell.time.to_i 
                    false_sp_num += mcell.false.to_i 
                end
            end
        end
    end
    end

    unless words_sp_list.empty?
        wlist_sp = words_sp_list.join(' ')
        olist_sp = ordinals_sp_list.join(' ')
        ncell.change_code('words_sp', wlist_sp)
        ncell.change_code('ordinals_sp', olist_sp)
        ncell.change_code('number_sp', number_sp_num)
        ncell.change_code('function_sp', function_sp_num)
        ncell.change_code('order_sp', order_sp_num)
        ncell.change_code('sing_ref_sp', sing_ref_sp_num)
        ncell.change_code('shapes_sp', shapes_sp_num)
        ncell.change_code('mag_comp_sp', mag_comp_sp_num)
        ncell.change_code('loc_dir_sp', loc_dir_sp_num)
        ncell.change_code('or_sp', or_sp_num)
        ncell.change_code('deictics_sp', deictics_sp_num)
        ncell.change_code('feat_prop_sp', feat_prop_sp_num)
        ncell.change_code('time_sp', time_sp_num)
        ncell.change_code('false_sp', false_sp_num)
    else 
        ncell.change_code('words_sp', '.')
        ncell.change_code('ordinals_sp', '.')
        ncell.change_code('number_sp', '.')
        ncell.change_code('function_sp', '.')
        ncell.change_code('order_sp', '.')
        ncell.change_code('sing_ref_sp', '.')
        ncell.change_code('shapes_sp', '.')
        ncell.change_code('mag_comp_sp', '.')
        ncell.change_code('loc_dir_sp', '.')
        ncell.change_code('or_sp', '.')
        ncell.change_code('deictics_sp', '.')
        ncell.change_code('feat_prop_sp', '.')
        ncell.change_code('time_sp', '.')
        ncell.change_code('false_sp', '.')
    end
end

if get_column_list().include?('child_eng_mathwords')  
words_en.cells.each do |wcell|
    wcellon = wcell.onset
    wcelloff = wcell.offset
    childmathwordonly_cell = gestmath.cells.select{ |g| wcellon >= g.onset-windowon && wcelloff <= g.offset+windowoff }
    if childmathwordonly_cell.empty?
        #Populate with information from math actions column
        ncell = com_col.new_cell
        if wcellon >= 0
            ncell.onset = wcellon
        else
            ncell.onset = 0
        end
        ncell.offset = wcelloff
        ncell.change_code('gestmath_ordinal', '.')
        ncell.change_code('ordinals_en', wcell.ordinal)
        ncell.change_code('words_en', wcell.words)
        ncell.change_code('ordinals_sp', '.')
        ncell.change_code('words_sp', '.')

        mathcat_en.cells.each do |mcell|
            if mcell.ordinal == wcell.ordinal 
                ncell.change_code('number_en', mcell.number)
                ncell.change_code('function_en', mcell.function)
                ncell.change_code('order_en', mcell.order)
                ncell.change_code('sing_ref_en', mcell.sing_ref)
                ncell.change_code('shapes_en', mcell.shapes)
                ncell.change_code('mag_comp_en', mcell.mag_comp)
                ncell.change_code('loc_dir_en', mcell.loc_dir)
                ncell.change_code('or_en', mcell.or)
                ncell.change_code('deictics_en', mcell.deictics)
                ncell.change_code('feat_prop_en', mcell.feat_prop)
                ncell.change_code('time_en', mcell.time)
                ncell.change_code('false_en', mcell.false)
                ncell.change_code('number_sp', '.')
                ncell.change_code('function_sp', '.')
                ncell.change_code('order_sp', '.')
                ncell.change_code('sing_ref_sp', '.')
                ncell.change_code('shapes_sp', '.')
                ncell.change_code('mag_comp_sp', '.')
                ncell.change_code('loc_dir_sp', '.')
                ncell.change_code('or_sp','.')
                ncell.change_code('deictics_sp', '.')
                ncell.change_code('feat_prop_sp', '.')
                ncell.change_code('time_sp', '.')
                ncell.change_code('false_sp', '.')
            end
        end
    end
end
end

if get_column_list().include?('child_spa_mathwords')  
words_sp.cells.each do |wcell|
    wcellon = wcell.onset
    wcelloff = wcell.offset
    childmathwordonly_cell = gestmath.cells.select{ |g| wcellon >= g.onset-windowon && wcelloff <= g.offset+windowoff }
    if childmathwordonly_cell.empty?
        #Populate with information from math actions column
        ncell = com_col.new_cell
        if wcellon >= 0
            ncell.onset = wcellon
        else
            ncell.onset = 0
        end
        ncell.offset = wcelloff
        ncell.change_code('gestmath_ordinal', '.')
        ncell.change_code('ordinals_sp', wcell.ordinal)
        ncell.change_code('words_sp', wcell.words)
        ncell.change_code('ordinals_en', '.')
        ncell.change_code('words_en', '.')

        mathcat_sp.cells.each do |mcell|
            if mcell.ordinal == wcell.ordinal 
                ncell.change_code('number_sp', mcell.number)
                ncell.change_code('function_sp', mcell.function)
                ncell.change_code('order_sp', mcell.order)
                ncell.change_code('sing_ref_sp', mcell.sing_ref)
                ncell.change_code('shapes_sp', mcell.shapes)
                ncell.change_code('mag_comp_sp', mcell.mag_comp)
                ncell.change_code('loc_dir_sp', mcell.loc_dir)
                ncell.change_code('or_sp', mcell.or)
                ncell.change_code('deictics_sp', mcell.deictics)
                ncell.change_code('feat_prop_sp', mcell.feat_prop)
                ncell.change_code('time_sp', mcell.time)
                ncell.change_code('false_sp', mcell.false)
                ncell.change_code('number_en', '.')
                ncell.change_code('function_en', '.')
                ncell.change_code('order_en', '.')
                ncell.change_code('sing_ref_en', '.')
                ncell.change_code('shapes_en', '.')
                ncell.change_code('mag_comp_en', '.')
                ncell.change_code('loc_dir_en', '.')
                ncell.change_code('or_en','.')
                ncell.change_code('deictics_en', '.')
                ncell.change_code('feat_prop_en', '.')
                ncell.change_code('time_en', '.')
                ncell.change_code('false_en', '.')
            end
        end
    end
end
end

set_column(com_col)
