/* config_save.p */

USING Progress.Json.ObjectModel.JsonObject.

DEFINE INPUT PARAMETER inYear   AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER inDay    AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER inExample    AS LOGICAL NO-UNDO.

DEFINE VARIABLE jRootObj    AS JsonObject   NO-UNDO.
DEFINE VARIABLE cFileName   AS CHARACTER    NO-UNDO INITIAL "cache.json".

/* — Create a JsonObject and assign keys/values — */
jRootObj = NEW JsonObject().
jRootObj:Add("year", inYear).
jRootObj:Add("day", inDay).
jRootObj:Add("example", inExample).

jRootObj:WriteFile(cFileName, TRUE).

RETURN.