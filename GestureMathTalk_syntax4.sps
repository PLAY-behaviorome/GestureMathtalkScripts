* Encoding: UTF-8.

**RECODE CHILDWORDS_____.

DATASET ACTIVATE childwords.
RECODE chi_mathtalk_parunigesture (1=1) (0=0) (SYSMIS=SYSMIS) INTO chi_mathtalk_par_total.
EXECUTE.

DO IF (chi_mathtalk_parunimathtalk = 1).
RECODE chi_mathtalk_par_total (0=2) (SYSMIS=2).
END IF.
EXECUTE.

DO IF (chi_mathtalk_parmultigestmath = 1).
RECODE chi_mathtalk_par_total (0=3) (SYSMIS=3).
END IF.
EXECUTE.

RECODE chi_mathtalk_par_total (0=4).
EXECUTE.

*ADD VALUES TO chi_mathtalk_par_total
    
RECODE chi_mathtalk_par_total (1=1) (2=1) (3=1) (4=2) INTO chi_mathtalk_par_vs_no_par.
EXECUTE.

*ADD VALUES TO chi_mathtalk_par_vs_no_par
   
**RECODE MATHACTION_____.

DATASET ACTIVATE mathaction.
RECODE chi_mathact_parunigesture (1=1) (0=0) (SYSMIS=SYSMIS) INTO chi_mathact_par_total.
EXECUTE.

DO IF (chi_mathact_parunimathtalk = 1).
RECODE chi_mathact_par_total (0=2) (SYSMIS=2).
END IF.
EXECUTE.

DO IF (chi_mathact_parmultigestmath = 1).
RECODE chi_mathact_par_total (0=3) (SYSMIS=3).
END IF.
EXECUTE.

RECODE chi_mathact_par_total (0=4).
EXECUTE.

*ADD VALUES TO chi_mathact_par_total

RECODE chi_mathact_par_total (1=1) (2=1) (3=1) (4=2) INTO chi_mathact_par_vs_no_par.
EXECUTE.

*ADD VALUES TO chi_mathact_par_vs_no_par

**RECODE CHILD GESTURE_____.

DATASET ACTIVATE childgesture.
RECODE chi_gesture_parunigesture (1=1) (0=0) (SYSMIS=SYSMIS) INTO chi_gesture_par_total.
EXECUTE.

DO IF (chi_gesture_parunimathtalk = 1).
RECODE chi_gesture_par_total (0=2) (SYSMIS=2).
END IF.
EXECUTE.

DO IF (chi_gesture_parmultigestmath = 1).
RECODE chi_gesture_par_total (0=3) (SYSMIS=3).
END IF.
EXECUTE.

RECODE chi_gesture_par_total (0=4).
EXECUTE.

*ADD VALUES TO chi_gesture_par_total

RECODE chi_gesture_par_total (1=1) (2=1) (3=1) (4=2) INTO chi_gesture_par_vs_no_par.
EXECUTE.

*ADD VALUES TO chi_gesture_par_vs_no_par
