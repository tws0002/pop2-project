import json


dict_out = {
    "Supported Applications":
        ["Maya 2016", "Houdini14.0.x" "Adobe CC", "Zbrush 4R7",
         "Nuke 9.x", "Renderman 20.0"]
}

with open('/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/my_CONFIG/data.txt', 'w') as outfile:
    json.dump(dict_out, outfile)
