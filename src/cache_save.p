/* config_save.p */

USING Progress.Json.ObjectModel.JsonObject.

DEFINE INPUT PARAMETER inYear AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER inDay  AS CHARACTER NO-UNDO.

DEFINE VARIABLE rootObj  AS JsonObject              NO-UNDO.
DEFINE VARIABLE lcOut    AS LONGCHAR                NO-UNDO.
DEFINE VARIABLE fileName AS CHARACTER               NO-UNDO INITIAL "cache.json".

/* — Create a JsonObject and assign keys/values — */
rootObj = NEW JsonObject().
rootObj:Add("year", inYear).
rootObj:Add("day", inDay).

rootObj:WriteFile(fileName, TRUE).

RETURN.