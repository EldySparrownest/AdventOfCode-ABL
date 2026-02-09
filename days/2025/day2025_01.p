/* day2025_01.p */

DEFINE INPUT PARAMETER httInput AS HANDLE NO-UNDO.
/* DEFINE OUTPUT PARAMETER outRes  AS CHARACTER NO-UNDO. */

/* Iterate the temp‑table via buffer from handle */
DEFINE VARIABLE hBuf AS HANDLE NO-UNDO.
DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.

ASSIGN hBuf = httInput:DEFAULT-BUFFER-HANDLE.

MESSAGE "I am in day2025_01.p" VIEW-AS ALERT-BOX.

/* Create and prepare the query */
CREATE QUERY hQuery.
hQuery:SET-BUFFERS(hBuf).
hQuery:QUERY-PREPARE("FOR EACH " + httInput:NAME).
hQuery:QUERY-OPEN().

/* Fetch first record */
hQuery:GET-FIRST().

/* Loop until end of result set */
DO WHILE NOT hQuery:QUERY-OFF-END:
    /*
    MESSAGE hBuf:BUFFER-FIELD("LineText"):BUFFER-VALUE
            VIEW-AS ALERT-BOX.
    */
    hQuery:GET-NEXT().
END.

/* Clean up */
hQuery:QUERY-CLOSE().
DELETE OBJECT hQuery.

RETURN.
