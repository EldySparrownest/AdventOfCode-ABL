/* FileLoadUtils.cls */

USING Progress.Json.ObjectModel.JsonObject.

CLASS utils.FileLoadUtils:
    DEFINE STATIC TEMP-TABLE ttLines
        FIELD LineText AS CHARACTER.

    /* TEMP-TABLE OUTPUT PARAM */
    METHOD PUBLIC STATIC VOID read_file_lines_tt (
        INPUT cFilePath AS CHARACTER,
        OUTPUT TABLE ttLines
    ):    
        DEFINE VARIABLE cLine     AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cLinesArr AS CHARACTER EXTENT NO-UNDO.
        DEFINE VARIABLE idx       AS INTEGER     NO-UNDO INITIAL 0.

        /* Ensure output temp-table is empty */
        FOR EACH ttLines:
            DELETE ttLines.
        END.

        /* Open the file path passed in */
        INPUT FROM VALUE(cFilePath) NO-ECHO.

        /* Read until end-of-file */
        REPEAT:
            IMPORT UNFORMATTED cLine.
            IF ERROR-STATUS:ERROR THEN LEAVE.

            CREATE ttLines.
            ASSIGN ttLines.LineText = cLine.
            MESSAGE cline VIEW-AS ALERT-BOX.
        END.

        INPUT CLOSE.
    END METHOD.

    /* RETURN TEMP-TABLE HANDLE */
    METHOD PUBLIC STATIC HANDLE read_file_lines_tth (
        INPUT cFilePath AS CHARACTER
    ):    
        DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.

        /* Ensure output temp-table is empty */
        FOR EACH ttLines:
            DELETE ttLines.
        END.

        /* Open the file path passed in */
        INPUT FROM VALUE(cFilePath) NO-ECHO.

        /* Read until end-of-file */
        REPEAT:
            IMPORT UNFORMATTED cLine NO-ERROR.
            IF ERROR-STATUS:ERROR THEN LEAVE.

            CREATE ttLines.
            ASSIGN ttLines.LineText = cLine.
        END.

        INPUT CLOSE.
        
        RETURN TEMP-TABLE ttLines:HANDLE.
    END METHOD.
END CLASS.
