/* main.p */

USING utils.FileLoadUtils.

DEFINE VARIABLE cYear     AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cDay      AS CHARACTER  NO-UNDO.
DEFINE VARIABLE lExample  AS LOGICAL    NO-UNDO.

DEFINE VARIABLE lValidDay AS LOGICAL    NO-UNDO.
DEFINE VARIABLE cReason   AS CHARACTER  NO-UNDO.

DEFINE BUTTON btnOK LABEL "OK".

DEFINE VARIABLE idx AS INTEGER NO-UNDO.
DEFINE TEMP-TABLE ttLines
  FIELD LineText AS CHARACTER.
DEFINE VARIABLE httInput AS HANDLE NO-UNDO.

DEFINE VARIABLE cResPart1 AS CHARACTER NO-UNDO.
DEFINE VARIABLE cResPart2 AS CHARACTER NO-UNDO.

{day_verification.p}

/* Load previous values first */
RUN cache_load.p (OUTPUT cYear, OUTPUT cDay, OUTPUT lExample).

FORM
  cYear     LABEL "Year"
  cDay      LABEL "Day"
  lExample  LABEL "Example" VIEW-AS TOGGLE-BOX
  btnOK
WITH FRAME f1
  VIEW-AS DIALOG-BOX
  SIDE-LABELS.

ON CHOOSE OF btnOK IN FRAME f1 DO:
  APPLY "GO" TO FRAME f1.
END.

DEFINE FRAME viewResults
  cYear     LABEL "Year"
  cDay      LABEL "Day"
  cResPart1 LABEL "P1"
  cResPart2 LABEL "P2"
WITH NO-BOX DOWN.

DO WHILE (NOT lValidDay):
  UPDATE cYear cDay lExample btnOk WITH FRAME f1.
  lValidDay = day_is_ready(cYear, cDay, lExample, OUTPUT cReason).
  IF (NOT lValidDay) THEN
    MESSAGE cReason VIEW-AS ALERT-BOX.
END.

/* Save day for next time */
RUN cache_save.p (INPUT cYear, INPUT cDay, INPUT lExample).

httInput = FileLoadUtils:read_file_lines_tth(
  INPUT get_input_path(cYear, cDay, lExample)).

RUN VALUE(get_procedure_path(cYear, cDay))(httInput,
  OUTPUT cResPart1, OUTPUT cResPart2).

DISPLAY cYear cDay cResPart1 cResPart2 WITH FRAME viewResults.
DOWN WITH FRAME viewResults.

PAUSE NO-MESSAGE.