* Encoding: UTF-8.
**PARENT BEHAVIORS AGGREGATE_______.
DATASET ACTIVATE childwords.
DATASET DECLARE gesturemathtalk_aggregated.
AGGREGATE
  /OUTFILE='gesturemathtalk_aggregated'
  /BREAK=id parent activity
  /par_unimodal_gesture_sum=SUM(par_unimodal_gesture) 
  /par_unimodal_mathtalk_sum=SUM(par_unimodal_mathtalk) 
  /par_multimodal_gestmath_sum=SUM(par_multimodal_gestmath).

**FIX ID VARIABLES_______.
DATASET ACTIVATE gesturemathtalk_aggregated.
RECODE parent activity ('mother'='Mother') ('mom'='Mother') ('Mom'='Mother') ('father'='Father') 
    ('dad'='Father') ('Dad'='Father') ('Shapesorter'='ShapeSorter') ('Shape sorter'='ShapeSorter') 
    ('shapesorter'='ShapeSorter') ('shape sorter'='ShapeSorter') ('Magnetboard'='MagnetBoard') 
    ('Magnet board'='MagnetBoard') ('magnetboard'='MagnetBoard') ('magnet board'='MagnetBoard').
EXECUTE.

**CHILD MATH TALK VARIABLES AGGREGATE_______.
DATASET ACTIVATE childwords.
DATASET DECLARE chi_mathtalk_aggregated.
AGGREGATE
  /OUTFILE='chi_mathtalk_aggregated'
  /BREAK=id parent activity
  /chi_mathtalk_sum=SUM(chi_mathtalk) 
  /chi_mathtalk_parunigesture_sum=SUM(chi_mathtalk_parunigesture) 
  /chi_mathtalk_parunimathtalk_sum=SUM(chi_mathtalk_parunimathtalk) 
  /chi_mathtalk_parmultigestmath_sum=SUM(chi_mathtalk_parmultigestmath) 
  /chi_mathtalk_nopar_sum=SUM(chi_mathtalk_nopar).
**ADD PARGEST, PAREN, PARSP, CHIEN, CHISP ORDINALS

**FIX CHILD MATH TALK VARIABLES_______.
DATASET ACTIVATE gesturemathtalk_aggregated.
*RENAME chi_mathtalk VARIABLES*

**CHILD MATH ACTION VARIABLES AGGREGATE_______.
DATASET ACTIVATE mathaction.
DATASET DECLARE chi_mathact_aggregated.
AGGREGATE
  /OUTFILE='chi_mathact_aggregated'
  /BREAK=id parent activity
  /chi_mathaction_occur_sum=SUM(chi_mathaction_occur) 
  /chi_mathact_parunigesture_sum=SUM(chi_mathact_parunigesture) 
  /chi_mathact_parunimathtalk_sum=SUM(chi_mathact_parunimathtalk) 
  /chi_mathact_parmultigestmath_sum=SUM(chi_mathact_parmultigestmath) 
  /chi_mathact_nopar_sum=SUM(chi_mathact_nopar).
**ADD MATHACT ORDINALS

**FIX CHILD MATH ACTION VARIABLES_______.
DATASET ACTIVATE gesturemathtalk_aggregated.
*RENAME chi_mathact VARIABLES*

**CHILD GESTURE VARIABLES AGGREGATE_______.
DATASET ACTIVATE childgesture.
DATASET DECLARE chi_gesture_aggregated.
AGGREGATE
  /OUTFILE='chigesture_aggregated'
  /BREAK=id parent activity
  /childgesture_occur_sum=SUM(childgesture_occur) 
  /chi_gesture_parunigesture_sum=SUM(chi_gesture_parunigesture) 
  /chi_gesture_parunimathtalk_sum=SUM(chi_gesture_parunimathtalk) 
  /chi_gesture_parmultigestmath_sum=SUM(chi_gesture_parmultigestmath) 
  /chi_gesture_nopar_sum=SUM(chi_gesture_nopar).
**ADD CHILD GESTURE ORDINALS

**FIX CHILD GESTURE VARIABLES_______.
DATASET ACTIVATE gesturemathtalk_aggregated.
*RENAME chi_gesture VARIABLES*

**REV CHILD MATH TALK VARIABLES AGGREGATE_______.
DATASET ACTIVATE rev_childwords.
DATASET DECLARE chi_mathtalk_rev_aggregated.
AGGREGATE
  /OUTFILE='chi_mathtalk_rev_aggregated'
  /BREAK=id parent activity
  /chi_mathtalk_sum=SUM(chi_mathtalk) 
  /chi_mathtalk_parunigesture_sum=SUM(chi_mathtalk_parunigesture) 
  /chi_mathtalk_parunimathtalk_sum=SUM(chi_mathtalk_parunimathtalk) 
  /chi_mathtalk_parmultigestmath_sum=SUM(chi_mathtalk_parmultigestmath) 
  /chi_mathtalk_nopar_sum=SUM(chi_mathtalk_nopar).

**FIX REV CHILD MATH TALK VARIABLE_______.
DATASET ACTIVATE gesturemathtalk_aggregated.
*RENAME chi_mathtalk_sum to chi_mathtalk_rev_sum*

**REV CHILD MATH ACTION VARIABLES AGGREGATE_______.
DATASET ACTIVATE rev_mathaction.
DATASET DECLARE chi_mathact_rev_aggregated.
AGGREGATE
  /OUTFILE='chi_mathact_rev_aggregated'
  /BREAK=id parent activity
  /chi_mathaction_occur_sum=SUM(chi_mathaction_occur) 
  /chi_mathact_parunigesture_sum=SUM(chi_mathact_parunigesture) 
  /chi_mathact_parunimathtalk_sum=SUM(chi_mathact_parunimathtalk) 
  /chi_mathact_parmultigestmath_sum=SUM(chi_mathact_parmultigestmath) 
  /chi_mathact_nopar_sum=SUM(chi_mathact_nopar).

**FIX REV CHILD MATH ACTION VARIABLE_______.
DATASET ACTIVATE gesturemathtalk_aggregated.
*RENAME chi_mathact_occur_sum to chi_mathact_occur_rev_sum*

**REV CHILD GESTURE VARIABLES AGGREGATE_______.
DATASET ACTIVATE rev_childgesture.
DATASET DECLARE chigesture_rev_aggregated.
AGGREGATE
  /OUTFILE='chigesture_rev_aggregated'
  /BREAK=id parent activity
  /childgesture_occur_sum=SUM(childgesture_occur) 
  /chi_gesture_parunigesture_sum=SUM(chi_gesture_parunigesture) 
  /chi_gesture_parunimathtalk_sum=SUM(chi_gesture_parunimathtalk) 
  /chi_gesture_parmultigestmath_sum=SUM(chi_gesture_parmultigestmath) 
  /chi_gesture_nopar_sum=SUM(chi_gesture_nopar).

**FIX REV CHILD GESTURE VARIABLE_______.
DATASET ACTIVATE gesturemathtalk_aggregated.
*RENAME chi_gesture_sum to chi_gesture_rev_sum*
   

**COMPUTE VARIABLES______.
DATASET ACTIVATE gesturemathtalk_aggregated.
COMPUTE par_chi_mathtalk_total_sum=parunigesture_chi_mathtalk_sum + parunimathtalk_chi_mathtalk_sum 
    + parmultigestmath_chi_mathtalk_sum.
EXECUTE.

COMPUTE par_chi_mathact_total_sum=parunigesture_chi_mathact_sum + parunimathtalk_chi_mathact_sum + 
    parmultigestmath_chi_mathact_sum.
EXECUTE.

COMPUTE par_chi_gesture_total_sum=parunigesture_chi_gesture_sum + parunimathtalk_chi_gesture_sum + 
    parmultigestmath_chi_gesture_sum.
EXECUTE.

COMPUTE chi_mathtalk_par_total_sum=chi_mathtalk_parunigesture_sum + chi_mathtalk_parunimathtalk_sum 
    + chi_mathtalk_parmultigestmath_sum.
EXECUTE.

COMPUTE chi_mathact_par_total_sum=chi_mathact_parunigesture_sum + chi_mathact_parunimathtalk_sum 
    + chi_mathact_parmultigestmath_sum.
EXECUTE.

COMPUTE chi_gesture_par_total_sum=chi_gesture_parunigesture_sum + chi_gesture_parunimathtalk_sum 
    + chi_gesture_parmultigestmath_sum.
EXECUTE.

T-TEST PAIRS=par_chi_mathtalk_total_sum WITH nopar_chi_mathtalk_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=par_chi_mathact_total_sum WITH nopar_chi_mathact_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=par_chi_gesture_total_sum WITH nopar_chi_gesture_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_mathtalk_par_total_sum WITH chi_mathtalk_nopar_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_mathact_par_total_sum WITH chi_mathact_nopar_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_gesture_par_total_sum WITH chi_gesture_nopar_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

COMPUTE par_chi_mean=MEAN(par_chi_mathtalk_total_sum, par_chi_mathact_total_sum, 
    par_chi_gesture_total_sum).
EXECUTE.

COMPUTE nopar_chi_mean=MEAN(nopar_chi_mathtalk_sum, nopar_chi_mathact_sum, nopar_chi_gesture_sum).
EXECUTE.

DESCRIPTIVES VARIABLES=par_chi_mean nopar_chi_mean
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

DATASET ACTIVATE child_gesturemathtalk_aggregated.
T-TEST PAIRS=par_chi_mathtalk_total_sum_sum WITH nopar_chi_mathtalk_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=par_chi_mathact_total_sum_sum WITH nopar_chi_mathact_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=par_chi_gesture_total_sum_sum WITH nopar_chi_gesture_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_mathtalk_par_total_sum_sum WITH chi_mathtalk_nopar_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_mathact_par_total_sum_sum WITH chi_mathact_nopar_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_gesture_par_total_sum_sum WITH chi_gesture_nopar_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

DATASET ACTIVATE DataSet1.
DATASET DECLARE chibyparent_gesturemathtalk_aggregated.
AGGREGATE
  /OUTFILE='chibyparent_gesturemathtalk_aggregated'
  /BREAK=id parent
  /par_unimodal_gesture_sum_sum=SUM(par_unimodal_gesture_sum) 
  /par_unimodal_mathtalk_sum_sum=SUM(par_unimodal_mathtalk_sum) 
  /par_multimodal_gestmath_sum_sum=SUM(par_multimodal_gestmath_sum) 
  /chi_mathtalk_sum_sum=SUM(chi_mathtalk_sum) 
  /parunigesture_chi_mathtalk_sum_sum=SUM(parunigesture_chi_mathtalk_sum) 
  /parunimathtalk_chi_mathtalk_sum_sum=SUM(parunimathtalk_chi_mathtalk_sum) 
  /parmultigestmath_chi_mathtalk_sum_sum=SUM(parmultigestmath_chi_mathtalk_sum) 
  /nopar_chi_mathtalk_sum_sum=SUM(nopar_chi_mathtalk_sum) 
  /chi_mathaction_occur_sum_sum=SUM(chi_mathaction_occur_sum) 
  /parunigesture_chi_mathact_sum_sum=SUM(parunigesture_chi_mathact_sum) 
  /parunimathtalk_chi_mathact_sum_sum=SUM(parunimathtalk_chi_mathact_sum) 
  /parmultigestmath_chi_mathact_sum_sum=SUM(parmultigestmath_chi_mathact_sum) 
  /nopar_chi_mathact_sum_sum=SUM(nopar_chi_mathact_sum) 
  /childgesture_occur_sum_sum=SUM(childgesture_occur_sum) 
  /parunigesture_chi_gesture_sum_sum=SUM(parunigesture_chi_gesture_sum) 
  /parunimathtalk_chi_gesture_sum_sum=SUM(parunimathtalk_chi_gesture_sum) 
  /parmultigestmath_chi_gesture_sum_sum=SUM(parmultigestmath_chi_gesture_sum) 
  /nopar_chi_gesture_sum_sum=SUM(nopar_chi_gesture_sum) 
  /chi_mathtalk_rev_sum_sum=SUM(chi_mathtalk_rev_sum) 
  /chi_mathtalk_parunigesture_sum_sum=SUM(chi_mathtalk_parunigesture_sum) 
  /chi_mathtalk_parunimathtalk_sum_sum=SUM(chi_mathtalk_parunimathtalk_sum) 
  /chi_mathtalk_parmultigestmath_sum_sum=SUM(chi_mathtalk_parmultigestmath_sum) 
  /chi_mathtalk_nopar_sum_sum=SUM(chi_mathtalk_nopar_sum) 
  /chi_mathaction_occur_rev_sum_sum=SUM(chi_mathaction_occur_rev_sum) 
  /chi_mathact_parunigesture_sum_sum=SUM(chi_mathact_parunigesture_sum) 
  /chi_mathact_parunimathtalk_sum_sum=SUM(chi_mathact_parunimathtalk_sum) 
  /chi_mathact_parmultigestmath_sum_sum=SUM(chi_mathact_parmultigestmath_sum) 
  /chi_mathact_nopar_sum_sum=SUM(chi_mathact_nopar_sum) 
  /chigesture_occur_rev_sum_sum=SUM(chigesture_occur_rev_sum) 
  /chi_gesture_parunigesture_sum_sum=SUM(chi_gesture_parunigesture_sum) 
  /chi_gesture_parunimathtalk_sum_sum=SUM(chi_gesture_parunimathtalk_sum) 
  /chi_gesture_parmultigestmath_sum_sum=SUM(chi_gesture_parmultigestmath_sum) 
  /chi_gesture_nopar_sum_sum=SUM(chi_gesture_nopar_sum) 
  /parbehavior_chibehavior_totalsum_sum=SUM(parbehavior_chibehavior_totalsum) 
  /chibehavior_parbehavior_totalsum_sum=SUM(chibehavior_parbehavior_totalsum) 
  /nopar_chibehavior_totalsum_sum=SUM(nopar_chibehavior_totalsum) 
  /chibehavior_nopar_totalsum_sum=SUM(chibehavior_nopar_totalsum) 
  /par_gest_ordinal_max_sum=SUM(par_gest_ordinal_max) 
  /chi_mathaction_ordinals_max_sum=SUM(chi_mathaction_ordinals_max) 
  /childgest_ordinals_max_sum=SUM(childgest_ordinals_max) 
  /chi_ordinals_en_max_sum=SUM(chi_ordinals_en_max) 
  /chi_ordinals_sp_max_sum=SUM(chi_ordinals_sp_max) 
  /par_ordinals_en_max_sum=SUM(par_ordinals_en_max) 
  /par_ordinals_sp_max_sum=SUM(par_ordinals_sp_max) 
  /par_chi_mathtalk_total_sum_sum=SUM(par_chi_mathtalk_total_sum) 
  /par_chi_mathact_total_sum_sum=SUM(par_chi_mathact_total_sum) 
  /par_chi_gesture_total_sum_sum=SUM(par_chi_gesture_total_sum) 
  /chi_mathtalk_par_total_sum_sum=SUM(chi_mathtalk_par_total_sum) 
  /chi_mathact_par_total_sum_sum=SUM(chi_mathact_par_total_sum) 
  /chi_gesture_par_total_sum_sum=SUM(chi_gesture_par_total_sum) 
  /par_chi_mean_sum=SUM(par_chi_mean) 
  /nopar_chi_mean_sum=SUM(nopar_chi_mean).


DATASET ACTIVATE chibyparent_gesturemathtalk_aggregated.
T-TEST PAIRS=par_chi_mathtalk_total_sum_sum WITH nopar_chi_mathtalk_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=par_chi_mathact_total_sum_sum WITH nopar_chi_mathact_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=par_chi_gesture_total_sum_sum WITH nopar_chi_gesture_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_mathtalk_par_total_sum_sum WITH chi_mathtalk_nopar_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_mathact_par_total_sum_sum WITH chi_mathact_nopar_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_gesture_par_total_sum_sum WITH chi_gesture_nopar_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

DATASET DECLARE chibyactivity_gesturemathtalk_aggregated.
AGGREGATE
  /OUTFILE='chibyactivity_gesturemathtalk_aggregated'
  /BREAK=id activity
  /par_unimodal_gesture_sum_sum=SUM(par_unimodal_gesture_sum) 
  /par_unimodal_mathtalk_sum_sum=SUM(par_unimodal_mathtalk_sum) 
  /par_multimodal_gestmath_sum_sum=SUM(par_multimodal_gestmath_sum) 
  /chi_mathtalk_sum_sum=SUM(chi_mathtalk_sum) 
  /parunigesture_chi_mathtalk_sum_sum=SUM(parunigesture_chi_mathtalk_sum) 
  /parunimathtalk_chi_mathtalk_sum_sum=SUM(parunimathtalk_chi_mathtalk_sum) 
  /parmultigestmath_chi_mathtalk_sum_sum=SUM(parmultigestmath_chi_mathtalk_sum) 
  /nopar_chi_mathtalk_sum_sum=SUM(nopar_chi_mathtalk_sum) 
  /chi_mathaction_occur_sum_sum=SUM(chi_mathaction_occur_sum) 
  /parunigesture_chi_mathact_sum_sum=SUM(parunigesture_chi_mathact_sum) 
  /parunimathtalk_chi_mathact_sum_sum=SUM(parunimathtalk_chi_mathact_sum) 
  /parmultigestmath_chi_mathact_sum_sum=SUM(parmultigestmath_chi_mathact_sum) 
  /nopar_chi_mathact_sum_sum=SUM(nopar_chi_mathact_sum) 
  /childgesture_occur_sum_sum=SUM(childgesture_occur_sum) 
  /parunigesture_chi_gesture_sum_sum=SUM(parunigesture_chi_gesture_sum) 
  /parunimathtalk_chi_gesture_sum_sum=SUM(parunimathtalk_chi_gesture_sum) 
  /parmultigestmath_chi_gesture_sum_sum=SUM(parmultigestmath_chi_gesture_sum) 
  /nopar_chi_gesture_sum_sum=SUM(nopar_chi_gesture_sum) 
  /chi_mathtalk_rev_sum_sum=SUM(chi_mathtalk_rev_sum) 
  /chi_mathtalk_parunigesture_sum_sum=SUM(chi_mathtalk_parunigesture_sum) 
  /chi_mathtalk_parunimathtalk_sum_sum=SUM(chi_mathtalk_parunimathtalk_sum) 
  /chi_mathtalk_parmultigestmath_sum_sum=SUM(chi_mathtalk_parmultigestmath_sum) 
  /chi_mathtalk_nopar_sum_sum=SUM(chi_mathtalk_nopar_sum) 
  /chi_mathaction_occur_rev_sum_sum=SUM(chi_mathaction_occur_rev_sum) 
  /chi_mathact_parunigesture_sum_sum=SUM(chi_mathact_parunigesture_sum) 
  /chi_mathact_parunimathtalk_sum_sum=SUM(chi_mathact_parunimathtalk_sum) 
  /chi_mathact_parmultigestmath_sum_sum=SUM(chi_mathact_parmultigestmath_sum) 
  /chi_mathact_nopar_sum_sum=SUM(chi_mathact_nopar_sum) 
  /chigesture_occur_rev_sum_sum=SUM(chigesture_occur_rev_sum) 
  /chi_gesture_parunigesture_sum_sum=SUM(chi_gesture_parunigesture_sum) 
  /chi_gesture_parunimathtalk_sum_sum=SUM(chi_gesture_parunimathtalk_sum) 
  /chi_gesture_parmultigestmath_sum_sum=SUM(chi_gesture_parmultigestmath_sum) 
  /chi_gesture_nopar_sum_sum=SUM(chi_gesture_nopar_sum) 
  /parbehavior_chibehavior_totalsum_sum=SUM(parbehavior_chibehavior_totalsum) 
  /chibehavior_parbehavior_totalsum_sum=SUM(chibehavior_parbehavior_totalsum) 
  /nopar_chibehavior_totalsum_sum=SUM(nopar_chibehavior_totalsum) 
  /chibehavior_nopar_totalsum_sum=SUM(chibehavior_nopar_totalsum) 
  /par_gest_ordinal_max_sum=SUM(par_gest_ordinal_max) 
  /chi_mathaction_ordinals_max_sum=SUM(chi_mathaction_ordinals_max) 
  /childgest_ordinals_max_sum=SUM(childgest_ordinals_max) 
  /chi_ordinals_en_max_sum=SUM(chi_ordinals_en_max) 
  /chi_ordinals_sp_max_sum=SUM(chi_ordinals_sp_max) 
  /par_ordinals_en_max_sum=SUM(par_ordinals_en_max) 
  /par_ordinals_sp_max_sum=SUM(par_ordinals_sp_max) 
  /par_chi_mathtalk_total_sum_sum=SUM(par_chi_mathtalk_total_sum) 
  /par_chi_mathact_total_sum_sum=SUM(par_chi_mathact_total_sum) 
  /par_chi_gesture_total_sum_sum=SUM(par_chi_gesture_total_sum) 
  /chi_mathtalk_par_total_sum_sum=SUM(chi_mathtalk_par_total_sum) 
  /chi_mathact_par_total_sum_sum=SUM(chi_mathact_par_total_sum) 
  /chi_gesture_par_total_sum_sum=SUM(chi_gesture_par_total_sum) 
  /par_chi_mean_sum=SUM(par_chi_mean) 
  /nopar_chi_mean_sum=SUM(nopar_chi_mean).

DATASET ACTIVATE chibyactivity_gesturemathtalk_aggregated.
T-TEST PAIRS=par_chi_mathtalk_total_sum_sum WITH nopar_chi_mathtalk_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=par_chi_mathact_total_sum_sum WITH nopar_chi_mathact_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=par_chi_gesture_total_sum_sum WITH nopar_chi_gesture_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_mathtalk_par_total_sum_sum WITH chi_mathtalk_nopar_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_mathact_par_total_sum_sum WITH chi_mathact_nopar_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=chi_gesture_par_total_sum_sum WITH chi_gesture_nopar_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.
