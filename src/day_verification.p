/* day_verification.p */

FUNCTION get_procedure_path RETURNS CHARACTER (INPUT year AS CHARACTER, INPUT day AS CHARACTER):
    RETURN "days/" + year + "/day" + year + "_" + day + ".p".
END FUNCTION.


FUNCTION day_is_ready RETURNS LOGICAL (
    INPUT cYear AS CHARACTER, 
    INPUT cDay AS CHARACTER, 
    OUTPUT cReason AS CHARACTER
):
    DEFINE VARIABLE lRes AS LOGICAL NO-UNDO INITIAL TRUE.
    
    DEFINE VARIABLE cProcPath   AS CHARACTER    NO-UNDO.
    DEFINE VARIABLE lProcFound  AS LOGICAL      NO-UNDO.

    /* TODO: verify that puzzle input exists */
    
    /* verify that procedure file exists */
    cProcPath  = get_procedure_path(cYear, cDay).
    lProcFound = SEARCH(cProcPath ) <> ?.
    lRes = lRes AND lProcFound.

    IF (NOT lProcFound) THEN DO:
        cReason = SUBSTITUTE("Procedure file &1 was not found", cProcPath ).
    END.

    RETURN lRes.
END FUNCTION.
