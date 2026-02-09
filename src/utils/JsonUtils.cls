/* JsonUtils.cls */

USING Progress.Json.ObjectModel.JsonObject.

CLASS utils.JsonUtils:
    METHOD PUBLIC STATIC CHARACTER get_attribute_char (
        INPUT jObject AS JsonObject, 
        INPUT cAttrName AS CHARACTER, 
        INPUT cDefaultValue AS CHARACTER
    ):    
        IF jObject:Has(cAttrName) THEN
            RETURN jObject:GetCharacter(cAttrName).
        ELSE
            RETURN cDefaultValue.
    END METHOD.
    
    METHOD PUBLIC STATIC LOGICAL get_attribute_log (
        INPUT jObject AS JsonObject, 
        INPUT cAttrName AS CHARACTER, 
        INPUT cDefaultValue AS LOGICAL
    ):    
        IF jObject:Has(cAttrName) THEN
            RETURN jObject:GetLogical(cAttrName).
        ELSE
            RETURN cDefaultValue.
    END METHOD.
END CLASS.
