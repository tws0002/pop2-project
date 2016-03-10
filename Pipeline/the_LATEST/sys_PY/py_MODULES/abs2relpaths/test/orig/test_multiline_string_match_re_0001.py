import re

string1 = """\
file -rdi 1 -ns "_ref_sphere_cache1" -rfn "_ref_sphere_cacheRN1" -op "VERS|2016|UVER|undef|MADE|undef|CHNG|Fri, Oct 09, 2015 12:05:47 AM|ICON|undef|INFO|undef|OBJN|22|INCL|undef(|LUNI|cm|TUNI|film|AUNI|deg|"
         -typ "mayaBinary" "C:/Users/SelecaoOne/Desktop/New folder/_ref_sphere_cache.mb";
"""


# fMatch_re = re.compile(r'"([\S]+)"')

# string1 = '"asdf*&#@%kasn:: df"'
# comp = r"^[^\<\>\:\"\/\\\|\?\*]"
# comp = r"[^a-zA-Z0-9-]"
#comp = r"[a-zA-Z0-9-:]"

pathReservedCharacters = r"[^a-zA-Z0-9]"
pathMatch = r'"([\S]+)"'
pathMatch = r'[^\"]*'
pathMatch = r'"([^"]*)"'
comp = "(({p})|{m})".format(p=pathReservedCharacters, m=pathMatch)
#comp = r'"([\S ]+)"'
fMatch_re = re.compile(pathMatch)
matchAll = re.findall(fMatch_re, string1)
print matchAll
