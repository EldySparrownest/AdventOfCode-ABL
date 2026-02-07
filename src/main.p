/* main.p */

DEFINE VARIABLE cYear AS CHARACTER NO-UNDO.
DEFINE VARIABLE cDay  AS CHARACTER NO-UNDO.
DEFINE VARIABLE cReason  AS CHARACTER NO-UNDO.
DEFINE VARIABLE lValidDay  AS LOGICAL NO-UNDO.

{day_verification.p}

/* Load previous values first */
RUN cache_load.p (OUTPUT cYear, OUTPUT cDay).

FORM
  cYear LABEL "Year"
  cDay  LABEL "Day"
WITH FRAME f1
  VIEW-AS DIALOG-BOX
  SIDE-LABELS.

DO WHILE (NOT lValidDay):
  UPDATE cYear cDay WITH FRAME f1.
  lValidDay = day_is_ready(cYear, cDay, OUTPUT cReason).
  IF (NOT lValidDay) THEN
    MESSAGE cReason VIEW-AS ALERT-BOX.
END.

/* Save day for next time */
RUN cache_save.p (INPUT cYear, INPUT cDay).

RUN VALUE(get_procedure_path(cYear, cDay)).
