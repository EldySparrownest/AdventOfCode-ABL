/* config_load.p */

USING Progress.Json.ObjectModel.JsonObject.
USING Progress.Json.ObjectModel.ObjectModelParser.
USING utils.JsonUtils.

DEFINE OUTPUT PARAMETER outYear AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER outDay  AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER outExample  AS LOGICAL NO-UNDO.

DEFINE VARIABLE jsonParser  AS ObjectModelParser    NO-UNDO.
DEFINE VARIABLE jObject     AS JsonObject           NO-UNDO.
DEFINE VARIABLE cFileName   AS CHARACTER            NO-UNDO INITIAL "cache.json".

IF SEARCH(cFileName) = ? THEN DO:
    /* File not found — initialize defaults */
    outYear = "".
    outDay  = "".
    outExample = FALSE.
    RETURN.
END.
ELSE DO:
    jsonParser = NEW ObjectModelParser().
    jObject = CAST(jsonParser:ParseFile(cFileName), JsonObject).  

    outYear = JsonUtils:get_attribute_char(jObject, "year", "").
    outDay = JsonUtils:get_attribute_char(jObject, "day", "").
    outExample = JsonUtils:get_attribute_log(jObject, "example", FALSE).
END.

RETURN.
