* Encoding: UTF-8.
--Create parent behavior proportions--

DATASET ACTIVATE gesturemathtalk_aggregated.
COMPUTE par_mathtalk_chibehavior_sum=parunimathtalk_chi_mathtalk_sum + 
    parunimathtalk_chi_mathact_sum + parunimathtalk_chi_gesture_sum.
EXECUTE.

COMPUTE par_mathtalk_chi_prop=par_mathtalk_chibehavior_sum / par_unimodal_mathtalk_sum.
EXECUTE.

COMPUTE par_gesture_chibehavior_sum=parunigesture_chi_mathtalk_sum + parunigesture_chi_mathact_sum 
    + parunigesture_chi_gesture_sum.
EXECUTE.

COMPUTE par_gesture_chi_prop=par_gesture_chibehavior_sum / par_unimodal_gesture_sum.
EXECUTE.

RECODE par_gesture_chi_prop par_mathtalk_chi_prop par_multi_chi_prop (SYSMIS=0).
EXECUTE.

COMPUTE par_multi_chibehavior_sum=parmultigestmath_chi_mathtalk_sum + 
    parmultigestmath_chi_mathact_sum + parmultigestmath_chi_gesture_sum.
EXECUTE.

COMPUTE par_multi_chi_prop=par_multi_chibehavior_sum / par_multimodal_gestmath_sum.
EXECUTE.

COMPUTE PG_CMT_prop=parunigesture_chi_mathtalk_sum / par_unimodal_gesture_sum.
EXECUTE.

COMPUTE PG_CMA_prop=parunigesture_chi_mathact_sum / par_unimodal_gesture_sum.
EXECUTE.

COMPUTE PG_CG_prop=parunigesture_chi_gesture_sum / par_unimodal_gesture_sum.
EXECUTE.

COMPUTE PMT_CMT_prop=parunimathtalk_chi_mathtalk_sum / par_unimodal_mathtalk_sum.
EXECUTE.

COMPUTE PMT_CMA_prop=parunimathtalk_chi_mathact_sum / par_unimodal_mathtalk_sum.
EXECUTE.

COMPUTE PMT_CG_prop=parunigesture_chi_gesture_sum / par_unimodal_mathtalk_sum.
EXECUTE.

COMPUTE PMGM_CMT_prop=parmultigestmath_chi_mathtalk_sum / par_multimodal_gestmath_sum.
EXECUTE.

COMPUTE PMGM_CMA_prop=parmultigestmath_chi_mathact_sum / par_multimodal_gestmath_sum.
EXECUTE.

COMPUTE PMGM_CG_prop=parmultigestmath_chi_gesture_sum / par_multimodal_gestmath_sum.
EXECUTE.

COMPUTE chibehavior_par_mathtalk_sum=chi_mathtalk_parunimathtalk_sum + 
    chi_mathact_parunimathtalk_sum + chi_gesture_parunimathtalk_sum.
EXECUTE.

COMPUTE chi_parmathtalk_prop=chibehavior_par_mathtalk_sum / par_unimodal_mathtalk_sum.
EXECUTE.

COMPUTE chibehavior_par_gesture_sum=parunigesture_chi_mathtalk_sum + parunigesture_chi_mathact_sum 
    + parunigesture_chi_gesture_sum.
EXECUTE.

COMPUTE chi_pargesture_prop=chibehavior_par_gesture_sum / par_unimodal_gesture_sum.
EXECUTE.

COMPUTE chibehavior_par_multigestmath_sum=parmultigestmath_chi_mathtalk_sum + parmultigestmath_chi_mathact_sum 
    + parmultigestmath_chi_gesture_sum.
EXECUTE.

COMPUTE chi_parmultigestmath_prop=chibehavior_par_multigestmath_sum / par_multimodal_gestmath_sum.
EXECUTE.

RECODE chi_pargesture_prop chi_parmathtalk_prop chi_parmultigestmath_prop (SYSMIS=0).
EXECUTE.

COMPUTE CMT_PG_prop=chi_mathtalk_parunigesture_sum / par_unimodal_gesture_sum.
EXECUTE.

COMPUTE CMA_PG_prop=chi_mathact_parunigesture_sum / par_unimodal_gesture_sum.
EXECUTE.

COMPUTE CG_PG_prop=chi_gesture_parunigesture_sum / par_unimodal_gesture_sum.
EXECUTE.

COMPUTE CMT_PMT_prop=chi_mathtalk_parunimathtalk_sum / par_unimodal_mathtalk_sum.
EXECUTE.

COMPUTE CMA_PMT_prop=chi_mathact_parunimathtalk_sum / par_unimodal_mathtalk_sum.
EXECUTE.

COMPUTE CG_PMT_prop=chi_gesture_parunigesture_sum / par_unimodal_mathtalk_sum.
EXECUTE.

COMPUTE CMT_PMGM_prop=chi_mathtalk_parmultigestmath_sum / par_multimodal_gestmath_sum.
EXECUTE.

COMPUTE CMA_PMGM_prop=chi_mathact_parmultigestmath_sum / par_multimodal_gestmath_sum.
EXECUTE.

COMPUTE CG_PMGM_prop=chi_gesture_parmultigestmath_sum / par_multimodal_gestmath_sum.
EXECUTE.

--Create child behavior proportions--
  
COMPUTE PG_CMT_chiprop=parunigesture_chi_mathtalk_sum / chi_mathtalk_sum.
EXECUTE.

COMPUTE PG_CMA_chiprop=parunigesture_chi_mathact_sum /chi_mathaction_occur_sum.
EXECUTE.

COMPUTE PG_CG_chiprop=parunigesture_chi_gesture_sum / childgesture_occur_sum.
EXECUTE.

COMPUTE PMT_CMT_chiprop=parunimathtalk_chi_mathtalk_sum / chi_mathtalk_sum.
EXECUTE.

COMPUTE PMT_CMA_chiprop=parunimathtalk_chi_mathact_sum / chi_mathaction_occur_sum.
EXECUTE.

COMPUTE PMT_CG_chiprop=parunigesture_chi_gesture_sum / childgesture_occur_sum.
EXECUTE.
EXECUTE.

COMPUTE PMGM_CMT_chiprop=parmultigestmath_chi_mathtalk_sum / chi_mathtalk_sum.
EXECUTE.

COMPUTE PMGM_CMA_chiprop=parmultigestmath_chi_mathact_sum / chi_mathaction_occur_sum.
EXECUTE.

COMPUTE PMGM_CG_chiprop=parmultigestmath_chi_gesture_sum / childgesture_occur_sum.
EXECUTE.

COMPUTE CMT_PG_chiprop=chi_mathtalk_parunigesture_sum / chi_mathtalk_sum.

COMPUTE CMA_PG_chiprop=chi_mathact_parunigesture_sum / chi_mathaction_occur_sum.
EXECUTE.

COMPUTE CG_PG_chiprop=chi_gesture_parunigesture_sum / childgesture_occur_sum.
EXECUTE.

COMPUTE CMT_PMT_chiprop=chi_mathtalk_parunimathtalk_sum / chi_mathtalk_sum.
EXECUTE.

COMPUTE CMA_PMT_chiprop=chi_mathact_parunimathtalk_sum / chi_mathaction_occur_sum.
EXECUTE.

COMPUTE CG_PMT_chiprop=chi_gesture_parunigesture_sum / childgesture_occur_sum.
EXECUTE.

COMPUTE CMT_PMGM_chiprop=chi_mathtalk_parmultigestmath_sum / chi_mathtalk_sum.
EXECUTE.

COMPUTE CMA_PMGM_chiprop=chi_mathact_parmultigestmath_sum / chi_mathaction_occur_sum.
EXECUTE.

COMPUTE CG_PMGM_chiprop=chi_gesture_parmultigestmath_sum / childgesture_occur_sum.
EXECUTE.

DATASET ACTIVATE parent_to_child_breakdown_proportion.

RECODE Parent_Behavior ('PMT_CMT_prop_sum'='PMT') ('PMT_CMA_prop_sum'='PMT') ('PMT_CG_prop_sum'='PMT') 
    ('PMGM_CMT_prop_sum'='PMGM') ('PMGM_CMA_prop_sum'='PMGM') ('PMGM_CG_prop_sum'='PMGM') ('PG_CMT_prop_sum'='PG') 
    ('PG_CMA_prop_sum'='PG') ('PG_CG_prop_sum'='PG').
EXECUTE.

RECODE Child_Behavior ('PMT_CMT_prop_sum'='CMT') ('PMT_CMA_prop_sum'='CMA') ('PMT_CG_prop_sum'='CG') 
    ('PMGM_CMT_prop_sum'='CMT') ('PMGM_CMA_prop_sum'='CMA') ('PMGM_CG_prop_sum'='CG') ('PG_CMT_prop_sum'='CMT') 
    ('PG_CMA_prop_sum'='CMA') ('PG_CG_prop_sum'='CG').
EXECUTE.

**____GLMs of Child Following Parent_____

GLM PG_CMT_prop_sum_sum PG_CMA_prop_sum_sum PG_CG_prop_sum_sum PMT_CMT_prop_sum_sum 
    PMT_CMA_prop_sum_sum PMT_CG_prop_sum_sum PMGM_CMT_prop_sum_sum PMGM_CMA_prop_sum_sum 
    PMGM_CG_prop_sum_sum
  /WSFACTOR=Parent_Behavior 3 Polynomial Child_Behavior 3 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Parent_Behavior) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(Child_Behavior) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(Parent_Behavior*Child_Behavior) COMPARE(Parent_Behavior) ADJ(BONFERRONI)
  /EMMEANS=TABLES(Parent_Behavior*Child_Behavior) COMPARE(Child_Behavior) ADJ(BONFERRONI)
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Parent_Behavior Child_Behavior Parent_Behavior*Child_Behavior.

GLM PG_CMT_chiprop_sum_sum PG_CMA_chiprop_sum_sum PG_CG_chiprop_sum_sum PMT_CMT_chiprop_sum_sum 
    PMT_CMA_chiprop_sum_sum PMT_CG_chiprop_sum_sum PMGM_CMT_chiprop_sum_sum PMGM_CMA_chiprop_sum_sum 
    PMGM_CG_chiprop_sum_sum
  /WSFACTOR=Child_Behavior 3 Polynomial Parent_Behavior 3 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Parent_Behavior) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(Child_Behavior) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(Child_Behavior*Parent_Behavior) COMPARE(Child_Behavior) ADJ(BONFERRONI)
  /EMMEANS=TABLES(Child_Behavior*Parent_Behavior) COMPARE(Parent_Behavior) ADJ(BONFERRONI)
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Child_Behavior Parent_Behavior Child_Behavior*Parent_Behavior.

 **____GLMs of Parent Following Child___

GLM CMT_PG_prop_sum_sum CMA_PG_prop_sum_sum CG_PG_prop_sum_sum CMT_PMT_prop_sum_sum 
    CMA_PMT_prop_sum_sum CG_PMT_prop_sum_sum CMT_PMGM_prop_sum_sum CMA_PMGM_prop_sum_sum 
    CG_PMGM_prop_sum_sum
  /WSFACTOR=Parent_Behavior 3 Polynomial Child_Behavior 3 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Parent_Behavior) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(Child_Behavior) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(Parent_Behavior*Child_Behavior) COMPARE(Parent_Behavior) ADJ(BONFERRONI)
  /EMMEANS=TABLES(Parent_Behavior*Child_Behavior) COMPARE(Child_Behavior) ADJ(BONFERRONI)
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Parent_Behavior Child_Behavior Parent_Behavior*Child_Behavior.

GLM CMT_PG_chiprop_sum_sum CMA_PG_chiprop_sum_sum CG_PG_chiprop_sum_sum CMT_PMT_chiprop_sum_sum 
    CMA_PMT_chiprop_sum_sum CG_PMT_chiprop_sum_sum CMT_PMGM_chiprop_sum_sum CMA_PMGM_chiprop_sum_sum 
    CG_PMGM_chiprop_sum_sum
  /WSFACTOR=Child_Behavior 3 Polynomial Parent_Behavior 3 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Parent_Behavior) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(Child_Behavior) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(Child_Behavior*Parent_Behavior) COMPARE(Child_Behavior) ADJ(BONFERRONI)
  /EMMEANS=TABLES(Child_Behavior*Parent_Behavior) COMPARE(Parent_Behavior) ADJ(BONFERRONI)
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Child_Behavior Parent_Behavior Child_Behavior*Parent_Behavior.

**____T-tests of of Child Following Parent with Parent Behavior as Baserate

T-TEST PAIRS=PMGM_CG_prop_sum_sum PMGM_CG_prop_sum_sum WITH PMT_CG_prop_sum_sum PG_CG_prop_sum_sum 
    (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=PMGM_CMT_prop_sum_sum PMGM_CMT_prop_sum_sum WITH PMT_CMT_prop_sum_sum 
    PG_CMT_prop_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=PMGM_CMA_prop_sum_sum PMGM_CMA_prop_sum_sum WITH PMT_CMA_prop_sum_sum 
    PG_CMA_prop_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

**____T-tests of of Child Following Parent with Child Behavior as Baserate
    
    
T-TEST PAIRS=PMGM_CG_chiprop_sum_sum PMGM_CG_chiprop_sum_sum WITH PMT_CG_chiprop_sum_sum 
    PG_CG_chiprop_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=PMGM_CMT_chiprop_sum_sum PMGM_CMT_chiprop_sum_sum WITH PMT_CMT_chiprop_sum_sum 
    PG_CMT_chiprop_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=PMGM_CMA_chiprop_sum_sum PMGM_CMA_chiprop_sum_sum WITH PMT_CMA_chiprop_sum_sum 
    PG_CMA_chiprop_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

**____T-tests of of Parent Following Child with Parent Behavior as Baserate

T-TEST PAIRS=CG_PMGM_prop_sum_sum CG_PMGM_prop_sum_sum WITH CG_PMT_prop_sum_sum CG_PG_prop_sum_sum 
    (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=CMT_PMGM_prop_sum_sum CMT_PMGM_prop_sum_sum WITH CMT_PMT_prop_sum_sum 
    CMT_PG_prop_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=CMA_PMGM_prop_sum_sum CMA_PMGM_prop_sum_sum WITH CMA_PMT_prop_sum_sum 
    CMA_PG_prop_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

**____T-tests of of Parent Following Child with Child Behavior as Baserate

T-TEST PAIRS=CG_PMGM_chiprop_sum_sum CG_PMGM_chiprop_sum_sum WITH CG_PMT_chiprop_sum_sum 
    CG_PG_chiprop_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=CMT_PMGM_chiprop_sum_sum CMT_PMGM_chiprop_sum_sum WITH CMT_PMT_chiprop_sum_sum 
    CMT_PG_chiprop_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=CMA_PMGM_chiprop_sum_sum CMA_PMGM_chiprop_sum_sum WITH CMA_PMT_chiprop_sum_sum 
    CMA_PG_chiprop_sum_sum (PAIRED)
  /ES DISPLAY(TRUE) STANDARDIZER(SD)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

