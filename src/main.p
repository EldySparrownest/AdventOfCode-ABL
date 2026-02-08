/* main.p */

DEFINE VARIABLE cYear     AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cDay      AS CHARACTER  NO-UNDO.
DEFINE VARIABLE lExample  AS LOGICAL    NO-UNDO.

DEFINE VARIABLE lValidDay AS LOGICAL    NO-UNDO.
DEFINE VARIABLE cReason   AS CHARACTER  NO-UNDO.

DEFINE BUTTON btnOK LABEL "OK".

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

DO WHILE (NOT lValidDay):
  UPDATE cYear cDay lExample btnOk WITH FRAME f1.
  lValidDay = day_is_ready(cYear, cDay, lExample, OUTPUT cReason).
  IF (NOT lValidDay) THEN
    MESSAGE cReason VIEW-AS ALERT-BOX.
END.

/* Save day for next time */
RUN cache_save.p (INPUT cYear, INPUT cDay, INPUT lExample).

RUN VALUE(get_procedure_path(cYear, cDay)).
