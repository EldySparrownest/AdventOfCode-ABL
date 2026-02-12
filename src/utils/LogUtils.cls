/* LogUtils.cls */

CLASS utils.LogUtils:
    DEFINE STATIC VARIABLE cLogLine AS CHARACTER.

    DEFINE FRAME frLog
        cLogLine FORMAT "x(78)"
    WITH NO-BOX DOWN.

    METHOD PUBLIC STATIC VOID log_frame (
        INPUT ipLogLine AS CHARACTER
    ):
        cLogLine = ipLogLine.
        DISPLAY cLogLine WITH FRAME frLog.
        DOWN WITH FRAME frLog.
    END METHOD.
END CLASS.
