/* day2025_01.p */

DEFINE INPUT PARAMETER httInput AS HANDLE NO-UNDO.
DEFINE OUTPUT PARAMETER outRes1 AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER outRes2 AS CHARACTER NO-UNDO.

DEFINE VARIABLE cWorkLineVal    AS CHARACTER.
DEFINE VARIABLE iSpinLength     AS INTEGER INITIAL 0.
DEFINE VARIABLE iDialPosition   AS INTEGER INITIAL 50.
DEFINE VARIABLE iResult1        AS INTEGER INITIAL 0.
DEFINE VARIABLE iResult2        AS INTEGER INITIAL 0.

/* Iterate the temp-table via buffer from handle */
DEFINE VARIABLE hBuf AS HANDLE NO-UNDO.
DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.

DEFINE VARIABLE cLogLine    AS CHARACTER.

DEFINE FRAME frLog
    cLogLine FORMAT "x(60)"
WITH NO-BOX DOWN.

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
        /*
        cLogLine = SUBSTITUTE("rotation > 100 (&1) -> count from &2 to &3",
         iSpinLength, iResult2, iResult2 + 1).
        DISPLAY cLogLine WITH FRAME frLog.
        DOWN WITH FRAME frLog.
        */

        iResult2 += 1.
        iSpinLength -= 100.
    END.

    IF (SUBSTRING(cWorkLineVal, 1, 1) = "R") THEN DO:
        /*
        cLogLine = SUBSTITUTE("from &1 rotate right by &2 to &3", iDialPosition, iSpinLength,
         iDialPosition + iSpinLength).
        DISPLAY cLogLine WITH FRAME frLog.
        DOWN WITH FRAME frLog.
        */

        IF (iDialPosition < 100 AND iDialPosition + iSpinLength >= 100) 
        THEN DO:
            /*
            cLogLine = SUBSTITUTE("dial goes > 100, so a 0 was clicked: count &1 to &2",
            iResult2, iResult2 + 1).
            DISPLAY cLogLine WITH FRAME frLog.
            DOWN WITH FRAME frLog.
            */

            iDialPosition -= 100.
            iResult2 += 1.
        END.

        iDialPosition += iSpinLength.
    END.
    ELSE DO:
        /*
        cLogLine = SUBSTITUTE("from &1 rotate left by &2 to &3", iDialPosition, iSpinLength,
         iDialPosition - iSpinLength).
        DISPLAY cLogLine WITH FRAME frLog.
        DOWN WITH FRAME frLog.
        */

        IF (iDialPosition > 0 AND iDialPosition - iSpinLength <= 0)
        THEN DO:
            /*
            cLogLine = SUBSTITUTE("dial was < 0, so a 0 was clicked: count &1 to &2",
            iResult2, iResult2 + 1).
            DISPLAY cLogLine WITH FRAME frLog.
            DOWN WITH FRAME frLog.
            */

            iResult2 += 1.
        END.

        IF (iDialPosition - iSpinLength < 0) THEN
            iDialPosition += 100.
        iDialPosition -= iSpinLength.
    END.
    
    IF (iDialPosition = 0) THEN DO:
        /*
        cLogLine = SUBSTITUTE("dial was at 0, so a 0 was clicked: count &1 to &2",
         iResult2, iResult2 + 1).
        DISPLAY cLogLine WITH FRAME frLog.
        DOWN WITH FRAME frLog.
        */
        ASSIGN
            iResult1 += 1
        .
    END.

    hQuery:GET-NEXT().
END.

/* MESSAGE SUBSTITUTE("The password is: &1", iResult1) VIEW-AS ALERT-BOX. */
outRes1 = STRING(iResult1).
outRes2 = STRING(iResult2).

/* Clean up */
hQuery:QUERY-CLOSE().
DELETE OBJECT hQuery.

RETURN.
