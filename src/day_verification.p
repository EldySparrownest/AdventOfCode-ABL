/* day_verification.p */

FUNCTION get_input_path RETURNS CHARACTER (
    INPUT year AS CHARACTER, INPUT day AS CHARACTER, INPUT example AS LOGICAL
):
    DEFINE VARIABLE cInputPath  AS CHARACTER    NO-UNDO.
    cInputPath = "inputs/" + year + "/Day" + day.
    IF (example) THEN
        cInputPath += "Example".
    cInputPath += ".txt".
    RETURN cInputPath.
END FUNCTION.

FUNCTION get_procedure_path RETURNS CHARACTER (INPUT year AS CHARACTER, INPUT day AS CHARACTER):
    RETURN "days/" + year + "/day" + year + "_" + day + ".p".
END FUNCTION.

FUNCTION day_is_ready RETURNS LOGICAL (
    INPUT cYear AS CHARACTER, 
    INPUT cDay AS CHARACTER, 
    INPUT lExample AS LOGICAL,
    OUTPUT cReason AS CHARACTER
):    
    DEFINE VARIABLE cInputPath   AS CHARACTER    NO-UNDO.
    DEFINE VARIABLE lInputFound  AS LOGICAL      NO-UNDO.
    
    DEFINE VARIABLE cProcPath   AS CHARACTER    NO-UNDO.
    DEFINE VARIABLE lProcFound  AS LOGICAL      NO-UNDO.

    /* verify that puzzle input file exists */
    cInputPath  = get_input_path(cYear, cDay, lExample).
    lInputFound = SEARCH(cInputPath) <> ?.
    
    IF (NOT lInputFound) THEN DO:
        cReason = SUBSTITUTE("Input file &1 was not found.", cInputPath).
        RETURN FALSE.
    END.

    /* verify that procedure file exists */
    cProcPath  = get_procedure_path(cYear, cDay).
    lProcFound = SEARCH(cProcPath) <> ?.

    IF (NOT lProcFound) THEN DO:
        cReason = SUBSTITUTE("Procedure file &1 was not found.", cProcPath).
        RETURN FALSE.
    END.

    RETURN TRUE.
END FUNCTION.
