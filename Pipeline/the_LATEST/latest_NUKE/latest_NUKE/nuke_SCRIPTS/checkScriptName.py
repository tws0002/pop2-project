import re
def checkScriptName( name ):
    if not re.search(r'.[vV]-\d+', name):
        raise Exception, 'The script name you\'re attempting to save with is not valid. Please conform with naming convention "aA-#"'
