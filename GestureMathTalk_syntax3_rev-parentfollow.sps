* Encoding: UTF-8.
***CHILD WORDS IMPORT REV-PARENT FOLLOW_________.
GET DATA  /TYPE=TXT
  /FILE="/Volumes/CRCDE$/CURRENT STUDIES AND PAPERS/NSF EDL1 Gesture and Math Talk/Results:Figures/SPSS/5secexports/export_rev_childwords.tsv"
  /DELCASE=LINE
  /DELIMITERS="\t"
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  id A7
  parent A10
  activity A15
  chi_ordinal F2.0
  chi_onset F6.0
  chi_offset F6.0
  chi_ordinals_en A10
  chi_words_en A25
  chi_number_en F1.0
  chi_function_en F1.0
  chi_order_en F1.0
  chi_sing_ref_en F1.0
  chi_shapes_en F1.0
  chi_mag_comp_en F1.0
  chi_loc_dir_en F1.0
  chi_or_en F1.0
  chi_deictics_en F1.0
  chi_feat_prop_en F1.0
  chi_time_en F1.0
  chi_false_en F1.0
  chi_ordinals_sp A10
  chi_words_sp A25
  chi_number_sp F1.0
  chi_function_sp F1.0
  chi_order_sp F1.0
  chi_sing_ref_sp F1.0
  chi_shapes_sp F1.0
  chi_mag_comp_sp F1.0
  chi_loc_dir_sp F1.0
  chi_or_sp F1.0
  chi_deictics_sp F1.0
  chi_feat_prop_sp F1.0
  chi_time_sp F1.0
  chi_false_sp F1.0
  par_gestmath_ordinal F2.0
  par_gest_ordinal F2.0
  par_gesture A1
  par_ordinals_en A10
  par_words_en A25
  par_number_en F1.0
  par_function_en F1.0
  par_order_en F1.0
  par_sing_ref_en F1.0
  par_shapes_en F1.0
  par_mag_comp_en F1.0
  par_loc_dir_en F1.0
  par_or_en F1.0
  par_deictics_en F1.0
  par_feat_prop_en F1.0
  par_time_en F1.0
  par_false_en F1.0
  par_ordinals_sp A10
  par_words_sp A25
  par_number_sp F1.0
  par_function_sp F1.0
  par_order_sp F1.0
  par_sing_ref_sp F1.0
  par_shapes_sp F1.0
  par_mag_comp_sp F1.0
  par_loc_dir_sp F1.0
  par_or_sp F1.0
  par_deictics_sp F1.0
  par_feat_prop_sp F1.0
  par_time_sp F1.0
  par_false_sp F1.0
  gestonly_notransc A1
  /MAP.
EXECUTE.
DATASET NAME rev_childwords.

**FIX ID VARIABLES_____.
STRING  id_unique (a5).
COMPUTE id_unique = CHAR.SUBSTR(id,1,5).
EXECUTE.

RECODE parent ('Father'=2) ('Mother'=1) ('mom'=1)('mother'= 1) INTO parent_role.
EXECUTE.
VALUE LABELS parent_role
  1.00 'mother'
  2.00 'father'.
EXECUTE.

RECODE activity ('magnetboard'= 1)('MagnetBoard'= 1)('Shape Sorter'= 2)('ShapeSorter'=2)('shapesorter'=2) INTO activity_name.
EXECUTE.
VALUE LABELS activity_name
    1.00 'magnetboard'
    2.00 'shapesorter'.
EXECUTE.
 
**RECODE PARENT EVENTS_____.
*If there is a parent event then make any gesture letter a 1 in occur and any missing a 0.
*Rows without parent event will stay as missing.
DO IF  (par_gestmath_ordinal  >= 1).
RECODE par_gesture ('.'=0) ('p'=1) ('s'=1) ('i'=1) ('c'=1) INTO par_gesture_occur.
END IF.
EXECUTE.

*If any math category other than singref or false is greater than or equal to 1 then this is mathtalk.
*If there is singref or false only this is not mathtalk.
*Events with no parent ordinal remain missing.
DO IF  (par_gestmath_ordinal  >= 1).
IF  (par_number_en>=1 OR par_function_en>=1 OR par_order_en>=1 OR par_shapes_en>=1 OR par_mag_comp_en>=1 OR par_loc_dir_en>=1 OR par_or_en>=1 OR par_deictics_en>=1 OR par_feat_prop_en>=1 OR par_time_en>=1
    OR  par_number_sp>=1 OR par_function_sp>=1 OR par_order_sp>=1 OR par_shapes_sp>=1 OR par_mag_comp_sp>=1 OR par_loc_dir_sp>=1 OR par_or_sp>=1 OR par_deictics_sp>=1 OR par_feat_prop_sp>=1 OR par_time_sp>=1) par_mathtalk=1.
DO IF  (par_number_en=0 AND par_function_en=0 AND par_order_en=0 AND par_shapes_en=0 AND par_mag_comp_en=0 AND par_loc_dir_en=0 AND par_or_en=0 AND par_deictics_en=0 AND par_feat_prop_en=0 AND par_time_en=0)
    OR (par_number_sp=0 AND par_function_sp=0 AND par_order_sp=0 AND par_shapes_sp=0 AND par_mag_comp_sp=0 AND par_loc_dir_sp=0 AND par_or_sp=0 AND par_deictics_sp=0 AND par_feat_prop_sp=0 AND par_time_sp=0).
IF (par_sing_ref_en>=1 OR par_sing_ref_sp>=1 OR par_false_en>=1 OR par_false_sp>=1) par_mathtalk=0.
IF (par_sing_ref_en=0 AND par_sing_ref_sp=0 AND par_false_en=0 AND par_false_sp=0) par_mathtalk=0.
END IF.
END IF.
EXECUTE.

IF SYSMIS(par_number_en) AND SYSMIS(par_false_sp) par_mathtalk=0.
EXECUTE.

DO IF  (par_gestmath_ordinal  >= 1).
RECODE par_mathtalk (SYSMIS=0) INTO par_mathtalk.
END IF.
EXECUTE.

**Create unimodal gesture.
DO IF par_gesture_occur=1 AND par_mathtalk=0 AND gestonly_notransc='y'.
    COMPUTE par_unimodal_gesture=1.
    COMPUTE par_unimodal_mathtalk=0.
    COMPUTE par_multimodal_gestmath=0.
END IF.
EXECUTE.


**Create unimodal mathtalk.
DO IF par_gesture_occur=0 AND par_mathtalk=1.
    COMPUTE par_unimodal_gesture=0.
    COMPUTE par_unimodal_mathtalk=1.
    COMPUTE par_multimodal_gestmath=0.
END IF.
EXECUTE.

**Create multimodal gesture and mathtalk.
DO IF par_gesture_occur=1 AND par_mathtalk=1.
    COMPUTE par_unimodal_gesture=0.
    COMPUTE par_unimodal_mathtalk=0.
    COMPUTE par_multimodal_gestmath=1.
END IF.
EXECUTE.

**RECODE CHILD WORDS EVENTS_____.
IF  (chi_number_en>=1 OR chi_function_en>=1 OR chi_order_en>=1 OR chi_shapes_en>=1 OR chi_mag_comp_en>=1 OR chi_loc_dir_en>=1 OR chi_or_en>=1 OR chi_deictics_en>=1 OR chi_feat_prop_en>=1 OR chi_time_en>=1
    OR  chi_number_sp>=1 OR chi_function_sp>=1 OR chi_order_sp>=1 OR chi_shapes_sp>=1 OR chi_mag_comp_sp>=1 OR chi_loc_dir_sp>=1 OR chi_or_sp>=1 OR chi_deictics_sp>=1 OR chi_feat_prop_sp>=1 OR chi_time_sp>=1) chi_mathtalk=1.
DO IF  (chi_number_en=0 AND chi_function_en=0 AND chi_order_en=0 AND chi_shapes_en=0 AND chi_mag_comp_en=0 AND chi_loc_dir_en=0 AND chi_or_en=0 AND chi_deictics_en=0 AND chi_feat_prop_en=0 AND chi_time_en=0)
    OR (chi_number_sp=0 AND chi_function_sp=0 AND chi_order_sp=0 AND chi_shapes_sp=0 AND chi_mag_comp_sp=0 AND chi_loc_dir_sp=0 AND chi_or_sp=0 AND chi_deictics_sp=0 AND chi_feat_prop_sp=0 AND chi_time_sp=0).
IF (chi_sing_ref_en>=1 OR chi_sing_ref_sp>=1 OR chi_false_en>=1 OR chi_false_sp>=1) chi_mathtalk=0.
IF (chi_sing_ref_en=0 AND chi_sing_ref_sp=0 AND chi_false_en=0 AND chi_false_sp=0) chi_mathtalk=0.
END IF.
EXECUTE.

**Create child follows unimodal gesture.
DO IF par_unimodal_gesture=1 AND chi_mathtalk=1.
    COMPUTE chi_mathtalk_parunigesture=1.
    COMPUTE chi_mathtalk_parunimathtalk=0.
    COMPUTE chi_mathtalk_parmultigestmath=0.
    COMPUTE chi_mathtalk_nopar=0.
END IF.
EXECUTE.

**Create child follows unimodal mathtalk.
DO IF par_unimodal_mathtalk=1 AND chi_mathtalk=1.
    COMPUTE chi_mathtalk_parunigesture=0.
    COMPUTE chi_mathtalk_parunimathtalk=1.
    COMPUTE chi_mathtalk_parmultigestmath=0.
    COMPUTE chi_mathtalk_nopar=0.
END IF.
EXECUTE.

**Create child follows multimodal gesture and mathtalk.
DO IF par_multimodal_gestmath=1 AND chi_mathtalk=1.
    COMPUTE chi_mathtalk_parunigesture=0.
    COMPUTE chi_mathtalk_parunimathtalk=0.
    COMPUTE chi_mathtalk_parmultigestmath=1.
    COMPUTE chi_mathtalk_nopar=0.
END IF.
EXECUTE.

**Create child without mathrelated parent event.
DO IF SYSMIS(par_unimodal_gesture) AND chi_mathtalk=1.
    COMPUTE chi_mathtalk_parunigesture=0.
    COMPUTE chi_mathtalk_parunimathtalk=0.
    COMPUTE chi_mathtalk_parmultigestmath=0.
    COMPUTE chi_mathtalk_nopar=1.
END IF.
EXECUTE.

FREQUENCIES VARIABLES=par_unimodal_gesture par_unimodal_mathtalk par_multimodal_gestmath
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=chi_mathtalk_parunigesture chi_mathtalk_parunimathtalk 
    chi_mathtalk_parmultigestmath chi_mathtalk_nopar
  /ORDER=ANALYSIS.

CROSSTABS
  /TABLES=chi_mathtalk_nopar BY gestonly_notransc par_mathtalk
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.



***CHILD MATHACTION IMPORT REV PARENT FOLLOW_________.
GET DATA  /TYPE=TXT
  /FILE="/Volumes/CRCDE$/CURRENT STUDIES AND PAPERS/NSF EDL1 Gesture and Math Talk/Results:Figures/SPSS/5secexports/export_rev_mathaction.tsv"
  /DELCASE=LINE
  /DELIMITERS="\t"
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  id A7
  parent A10
  activity A15
  chi_ordinal F2.0
  chi_onset F6.0
  chi_offset F6.0
  chi_mathaction_ordinals A10
  chi_mathaction_p F1.0
  par_gestmath_ordinal F2.0
  par_gest_ordinal F2.0
  par_gesture A1
  par_ordinals_en A10
  par_words_en A25
  par_number_en F1.0
  par_function_en F1.0
  par_order_en F1.0
  par_sing_ref_en F1.0
  par_shapes_en F1.0
  par_mag_comp_en F1.0
  par_loc_dir_en F1.0
  par_or_en F1.0
  par_deictics_en F1.0
  par_feat_prop_en F1.0
  par_time_en F1.0
  par_false_en F1.0
  par_ordinals_sp A10
  par_words_sp A25
  par_number_sp F1.0
  par_function_sp F1.0
  par_order_sp F1.0
  par_sing_ref_sp F1.0
  par_shapes_sp F1.0
  par_mag_comp_sp F1.0
  par_loc_dir_sp F1.0
  par_or_sp F1.0
  par_deictics_sp F1.0
  par_feat_prop_sp F1.0
  par_time_sp F1.0
  par_false_sp F1.0
  gestonly_notransc A1
  /MAP.
EXECUTE.
DATASET NAME rev_mathaction.

**FIX ID VARIABLES_____.
STRING  id_unique (a5).
COMPUTE id_unique = CHAR.SUBSTR(id,1,5).
EXECUTE.

RECODE parent ('Father'=2) ('Mother'=1) ('mom'=1)('mother'= 1) INTO parent_role.
EXECUTE.
VALUE LABELS parent_role
  1.00 'mother'
  2.00 'father'.
EXECUTE.

RECODE activity ('magnetboard'= 1)('MagnetBoard'= 1)('Shape Sorter'= 2)('ShapeSorter'=2)('shapesorter'=2) INTO activity_name.
EXECUTE.
VALUE LABELS activity_name
    1.00 'magnetboard'
    2.00 'shapesorter'.
EXECUTE.
 
**RECODE PARENT EVENTS_____.
*If there is a parent event then make any gesture letter a 1 in occur and any missing a 0.
*Rows without parent event will stay as missing.
DO IF  (par_gestmath_ordinal  >= 1).
RECODE par_gesture ('.'=0) ('p'=1) ('s'=1) ('i'=1) ('c'=1) INTO par_gesture_occur.
END IF.
EXECUTE.

*If any math category other than singref or false is greater than or equal to 1 then this is mathtalk.
*If there is singref or false only this is not mathtalk.
*Events with no parent ordinal remain missing.
DO IF  (par_gestmath_ordinal  >= 1).
IF  (par_number_en>=1 OR par_function_en>=1 OR par_order_en>=1 OR par_shapes_en>=1 OR par_mag_comp_en>=1 OR par_loc_dir_en>=1 OR par_or_en>=1 OR par_deictics_en>=1 OR par_feat_prop_en>=1 OR par_time_en>=1
    OR  par_number_sp>=1 OR par_function_sp>=1 OR par_order_sp>=1 OR par_shapes_sp>=1 OR par_mag_comp_sp>=1 OR par_loc_dir_sp>=1 OR par_or_sp>=1 OR par_deictics_sp>=1 OR par_feat_prop_sp>=1 OR par_time_sp>=1) par_mathtalk=1.
DO IF  (par_number_en=0 AND par_function_en=0 AND par_order_en=0 AND par_shapes_en=0 AND par_mag_comp_en=0 AND par_loc_dir_en=0 AND par_or_en=0 AND par_deictics_en=0 AND par_feat_prop_en=0 AND par_time_en=0)
    OR (par_number_sp=0 AND par_function_sp=0 AND par_order_sp=0 AND par_shapes_sp=0 AND par_mag_comp_sp=0 AND par_loc_dir_sp=0 AND par_or_sp=0 AND par_deictics_sp=0 AND par_feat_prop_sp=0 AND par_time_sp=0).
IF (par_sing_ref_en>=1 OR par_sing_ref_sp>=1 OR par_false_en>=1 OR par_false_sp>=1) par_mathtalk=0.
IF (par_sing_ref_en=0 AND par_sing_ref_sp=0 AND par_false_en=0 AND par_false_sp=0) par_mathtalk=0.
END IF.
END IF.
EXECUTE.

IF SYSMIS(par_number_en) AND SYSMIS(par_false_sp) par_mathtalk=0.
EXECUTE.

DO IF  (par_gestmath_ordinal  >= 1).
RECODE par_mathtalk (SYSMIS=0) INTO par_mathtalk.
END IF.
EXECUTE.

**Create unimodal gesture.
DO IF par_gesture_occur=1 AND par_mathtalk=0 AND gestonly_notransc='y'.
    COMPUTE par_unimodal_gesture=1.
    COMPUTE par_unimodal_mathtalk=0.
    COMPUTE par_multimodal_gestmath=0.
END IF.
EXECUTE.

**Create unimodal mathtalk.
DO IF par_gesture_occur=0 AND par_mathtalk=1.
    COMPUTE par_unimodal_gesture=0.
    COMPUTE par_unimodal_mathtalk=1.
    COMPUTE par_multimodal_gestmath=0.
END IF.
EXECUTE.

**Create multimodal gesture and mathtalk.
DO IF par_gesture_occur=1 AND par_mathtalk=1.
    COMPUTE par_unimodal_gesture=0.
    COMPUTE par_unimodal_mathtalk=0.
    COMPUTE par_multimodal_gestmath=1.
END IF.
EXECUTE.

**RECODE CHILD MATHACTION EVENTS_____.
 IF chi_mathaction_p >=1 chi_mathaction_occur =1.
EXECUTE.

**Create child follows unimodal gesture.
DO IF par_unimodal_gesture=1 AND chi_mathaction_occur=1.
    COMPUTE chi_mathact_parunigesture=1.
    COMPUTE chi_mathact_parunimathtalk=0.
    COMPUTE chi_mathact_parmultigestmath=0.
    COMPUTE chi_mathact_nopar=0.
END IF.
EXECUTE.

**Create child follows unimodal mathtalk.
DO IF par_unimodal_mathtalk=1 AND chi_mathaction_occur=1.
    COMPUTE chi_mathact_parunigesture=0.
    COMPUTE chi_mathact_parunimathtalk=1.
    COMPUTE chi_mathact_parmultigestmath=0.
    COMPUTE chi_mathact_nopar=0.
END IF.
EXECUTE.

**Create child follows multimodal gesture and mathtalk.
DO IF par_multimodal_gestmath=1 AND chi_mathaction_occur=1.
    COMPUTE chi_mathact_parunigesture=0.
    COMPUTE chi_mathact_parunimathtalk=0.
    COMPUTE chi_mathact_parmultigestmath=1.
    COMPUTE chi_mathact_nopar=0.
END IF.
EXECUTE.

**Create child without mathrelated parent event.
DO IF SYSMIS(par_unimodal_gesture) AND chi_mathaction_occur=1.
    COMPUTE chi_mathact_parunigesture=0.
    COMPUTE chi_mathact_parunimathtalk=0.
    COMPUTE chi_mathact_parmultigestmath=0.
    COMPUTE chi_mathact_nopar=1.
END IF.
EXECUTE.

FREQUENCIES VARIABLES=par_unimodal_gesture par_unimodal_mathtalk par_multimodal_gestmath
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=chi_mathact_parunigesture chi_mathact_parunimathtalk 
    chi_mathact_parmultigestmath chi_mathact_nopar
  /ORDER=ANALYSIS.

CROSSTABS
  /TABLES=chi_mathact_nopar BY gestonly_notransc par_mathtalk
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.


***CHILD GESTURE IMPORT REV PARENT FOLLOWS_________.
GET DATA  /TYPE=TXT
  /FILE="/Volumes/CRCDE$/CURRENT STUDIES AND PAPERS/NSF EDL1 Gesture and Math Talk/Results:Figures/SPSS/5secexports/export_rev_childgesture.tsv"
  /DELCASE=LINE
  /DELIMITERS="\t"
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  id A7
  parent A10
  activity A15
  chi_ordinal F2.0
  chi_onset F6.0
  chi_offset F6.0
  childgest_ordinals A10
  childgest_p F1.0
  childgest_s F1.0
  childgest_i F1.0
  childgest_c F1.0
  par_gestmath_ordinal F2.0
  par_gest_ordinal F2.0
  par_gesture A1
  par_ordinals_en A10
  par_words_en A25
  par_number_en F1.0
  par_function_en F1.0
  par_order_en F1.0
  par_sing_ref_en F1.0
  par_shapes_en F1.0
  par_mag_comp_en F1.0
  par_loc_dir_en F1.0
  par_or_en F1.0
  par_deictics_en F1.0
  par_feat_prop_en F1.0
  par_time_en F1.0
  par_false_en F1.0
  par_ordinals_sp A10
  par_words_sp A25
  par_number_sp F1.0
  par_function_sp F1.0
  par_order_sp F1.0
  par_sing_ref_sp F1.0
  par_shapes_sp F1.0
  par_mag_comp_sp F1.0
  par_loc_dir_sp F1.0
  par_or_sp F1.0
  par_deictics_sp F1.0
  par_feat_prop_sp F1.0
  par_time_sp F1.0
  par_false_sp F1.0
  gestonly_notransc A1
  /MAP.
EXECUTE.
DATASET NAME rev_childgesture.

**FIX ID VARIABLES_____.
STRING  id_unique (a5).
COMPUTE id_unique = CHAR.SUBSTR(id,1,5).
EXECUTE.

RECODE parent ('Father'=2) ('Mother'=1) ('mom'=1)('mother'= 1) INTO parent_role.
EXECUTE.
VALUE LABELS parent_role
  1.00 'mother'
  2.00 'father'.
EXECUTE.

RECODE activity ('magnetboard'= 1)('MagnetBoard'= 1)('Shape Sorter'= 2)('ShapeSorter'=2)('shapesorter'=2) INTO activity_name.
EXECUTE.
VALUE LABELS activity_name
    1.00 'magnetboard'
    2.00 'shapesorter'.
EXECUTE.
 
**RECODE PARENT EVENTS_____.
*If there is a parent event then make any gesture letter a 1 in occur and any missing a 0.
*Rows without parent event will stay as missing.
DO IF  (par_gestmath_ordinal  >= 1).
RECODE par_gesture ('.'=0) ('p'=1) ('s'=1) ('i'=1) ('c'=1) INTO par_gesture_occur.
END IF.
EXECUTE.

*If any math category other than singref or false is greater than or equal to 1 then this is mathtalk.
*If there is singref or false only this is not mathtalk.
*Events with no parent ordinal remain missing.
DO IF  (par_gestmath_ordinal  >= 1).
IF  (par_number_en>=1 OR par_function_en>=1 OR par_order_en>=1 OR par_shapes_en>=1 OR par_mag_comp_en>=1 OR par_loc_dir_en>=1 OR par_or_en>=1 OR par_deictics_en>=1 OR par_feat_prop_en>=1 OR par_time_en>=1
    OR  par_number_sp>=1 OR par_function_sp>=1 OR par_order_sp>=1 OR par_shapes_sp>=1 OR par_mag_comp_sp>=1 OR par_loc_dir_sp>=1 OR par_or_sp>=1 OR par_deictics_sp>=1 OR par_feat_prop_sp>=1 OR par_time_sp>=1) par_mathtalk=1.
DO IF  (par_number_en=0 AND par_function_en=0 AND par_order_en=0 AND par_shapes_en=0 AND par_mag_comp_en=0 AND par_loc_dir_en=0 AND par_or_en=0 AND par_deictics_en=0 AND par_feat_prop_en=0 AND par_time_en=0)
    OR (par_number_sp=0 AND par_function_sp=0 AND par_order_sp=0 AND par_shapes_sp=0 AND par_mag_comp_sp=0 AND par_loc_dir_sp=0 AND par_or_sp=0 AND par_deictics_sp=0 AND par_feat_prop_sp=0 AND par_time_sp=0).
IF (par_sing_ref_en>=1 OR par_sing_ref_sp>=1 OR par_false_en>=1 OR par_false_sp>=1) par_mathtalk=0.
IF (par_sing_ref_en=0 AND par_sing_ref_sp=0 AND par_false_en=0 AND par_false_sp=0) par_mathtalk=0.
END IF.
END IF.
EXECUTE.

IF SYSMIS(par_number_en) AND SYSMIS(par_false_sp) par_mathtalk=0.
EXECUTE.

DO IF  (par_gestmath_ordinal  >= 1).
RECODE par_mathtalk (SYSMIS=0) INTO par_mathtalk.
END IF.
EXECUTE.

**Create unimodal gesture.
DO IF par_gesture_occur=1 AND par_mathtalk=0 AND gestonly_notransc='y'.
    COMPUTE par_unimodal_gesture=1.
    COMPUTE par_unimodal_mathtalk=0.
    COMPUTE par_multimodal_gestmath=0.
END IF.
EXECUTE.

**Create unimodal mathtalk.
DO IF par_gesture_occur=0 AND par_mathtalk=1.
    COMPUTE par_unimodal_gesture=0.
    COMPUTE par_unimodal_mathtalk=1.
    COMPUTE par_multimodal_gestmath=0.
END IF.
EXECUTE.

**Create multimodal gesture and mathtalk.
DO IF par_gesture_occur=1 AND par_mathtalk=1.
    COMPUTE par_unimodal_gesture=0.
    COMPUTE par_unimodal_mathtalk=0.
    COMPUTE par_multimodal_gestmath=1.
END IF.
EXECUTE.

**RECODE CHILD GESTURE EVENTS_____.
IF (childgest_p>=1 OR childgest_s>=1 OR childgest_i>=1 OR childgest_c>=1) childgesture_occur=1.
EXECUTE.   

**Create child follows unimodal gesture.
DO IF par_unimodal_gesture=1 AND childgesture_occur=1.
    COMPUTE chi_gesture_parunigesture=1.
    COMPUTE chi_gesture_parunimathtalk=0.
    COMPUTE chi_gesture_parmultigestmath=0.
    COMPUTE chi_gesture_nopar=0.
END IF.
EXECUTE.

**Create child follows unimodal mathtalk.
DO IF par_unimodal_mathtalk=1 AND childgesture_occur=1.
    COMPUTE chi_gesture_parunigesture=0.
    COMPUTE chi_gesture_parunimathtalk=1.
    COMPUTE chi_gesture_parmultigestmath=0.
    COMPUTE chi_gesture_nopar=0.
END IF.
EXECUTE.

**Create child follows multimodal gesture and mathtalk.
DO IF par_multimodal_gestmath=1 AND childgesture_occur=1.
    COMPUTE chi_gesture_parunigesture=0.
    COMPUTE chi_gesture_parunimathtalk=0.
    COMPUTE chi_gesture_parmultigestmath=1.
    COMPUTE chi_gesture_nopar=0.
END IF.
EXECUTE.

**Create child without mathrelated parent event.
DO IF SYSMIS(par_unimodal_gesture) AND childgesture_occur=1.
    COMPUTE chi_gesture_parunigesture=0.
    COMPUTE chi_gesture_parunimathtalk=0.
    COMPUTE chi_gesture_parmultigestmath=0.
    COMPUTE chi_gesture_nopar=1.
END IF.
EXECUTE.

FREQUENCIES VARIABLES=par_unimodal_gesture par_unimodal_mathtalk par_multimodal_gestmath
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=chi_gesture_parunigesture chi_gesture_parunimathtalk 
    chi_gesture_parmultigestmath chi_gesture_nopar
  /ORDER=ANALYSIS.

CROSSTABS
  /TABLES=chi_gesture_nopar BY gestonly_notransc par_mathtalk
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.
