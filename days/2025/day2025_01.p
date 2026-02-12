/* day2025_01.p */

USING utils.LogUtils.

DEFINE INPUT PARAMETER httInput AS HANDLE NO-UNDO.
DEFINE OUTPUT PARAMETER outRes1 AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER outRes2 AS CHARACTER NO-UNDO.

DEFINE VARIABLE cWorkLineVal    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iSpinLength     AS INTEGER INITIAL 0    NO-UNDO.
DEFINE VARIABLE iDialPosition   AS INTEGER INITIAL 50   NO-UNDO.
DEFINE VARIABLE iResult1        AS INTEGER INITIAL 0    NO-UNDO.
DEFINE VARIABLE iResult2        AS INTEGER INITIAL 0    NO-UNDO.

/* Iterate the temp-table via buffer from handle */
DEFINE VARIABLE hBuf AS HANDLE NO-UNDO.
DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.

ASSIGN hBuf = httInput:DEFAULT-BUFFER-HANDLE.

/* MESSAGE "I am in day2025_01.p" VIEW-AS ALERT-BOX. */

/* Create and prepare the query */
CREATE QUERY hQuery.
hQuery:SET-BUFFERS(hBuf).
hQuery:QUERY-PREPARE("FOR EACH " + httInput:NAME).
hQuery:QUERY-OPEN().

/* Fetch first record */
hQuery:GET-FIRST().

/* Loop until end of result set */
DO WHILE NOT hQuery:QUERY-OFF-END:
    cWorkLineVal = hBuf:BUFFER-FIELD("LineText"):BUFFER-VALUE.
    iSpinLength = INTEGER(SUBSTRING(cWorkLineVal, 2)) NO-ERROR.
    IF ERROR-STATUS:ERROR THEN DO:
        MESSAGE SUBSTITUTE("Integer conversion failed in line &1 for &2",
        cWorkLineVal, SUBSTRING(cWorkLineVal, 2)) VIEW-AS ALERT-BOX.
        RETURN.
    END.
    
    DO WHILE (iSpinLength > 100):
        /* LogUtils:log_frame(SUBSTITUTE("rotation > 100 (&1) -> count from &2 to &3",
         iSpinLength, iResult2, iResult2 + 1)). */

        iResult2 += 1.
        iSpinLength -= 100.
    END.

    IF (SUBSTRING(cWorkLineVal, 1, 1) = "R") THEN DO:
        /* LogUtils:log_frame(INPUT SUBSTITUTE("from &1 rotate right by &2 to &3",
         iDialPosition, iSpinLength, iDialPosition + iSpinLength)). */

        IF (iDialPosition < 100 AND iDialPosition + iSpinLength >= 100) 
        THEN DO:
            /* LogUtils:log_frame(SUBSTITUTE("dial goes > 100, so a 0 was clicked: count &1 to &2",
             iResult2, iResult2 + 1)). */

            iDialPosition -= 100.
            iResult2 += 1.
        END.

        iDialPosition += iSpinLength.
    END.
    ELSE DO:
        /* LogUtils:log_frame(SUBSTITUTE("from &1 rotate left by &2 to &3",
         iDialPosition, iSpinLength, iDialPosition - iSpinLength)). */

        IF (iDialPosition > 0 AND iDialPosition - iSpinLength <= 0)
        THEN DO:
            /* LogUtils:log_frame(SUBSTITUTE("dial was < 0, so a 0 was clicked: count &1 to &2",
             iResult2, iResult2 + 1)). */

            iResult2 += 1.
        END.

        IF (iDialPosition - iSpinLength < 0) THEN
            iDialPosition += 100.
        iDialPosition -= iSpinLength.
    END.
    
    IF (iDialPosition = 0) THEN DO:
        /* LogUtils:log_frame(SUBSTITUTE("dial was at 0, so a 0 was clicked: count &1 to &2",
         iResult2, iResult2 + 1)). */

        ASSIGN
            iResult1 += 1
        .
    END.

    hQuery:GET-NEXT().
END.

outRes1 = STRING(iResult1).
outRes2 = STRING(iResult2).

/* Clean up */
hQuery:QUERY-CLOSE().
DELETE OBJECT hQuery.

RETURN.
