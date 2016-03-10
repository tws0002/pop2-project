#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import json
import constants as consts

initDict = {
                "FOPEN_PREFS": {
                    "LAST_OPENED_APPLICATION": "nuke",
                    "LAST_OPENED": "",
                    "UI_PREF_APPLICATION": "nuke",
                    "UI_PREF_SCENE": "1",
                    "UI_PREF_SHOT": "",
                    "UI_PREF_CHOICE": "Automatic {by filename}"
                }
            }

dictH = consts.CREWSHEET
with open(dictH, "r") as f:
    data = json.load(f)
dictH = data
for key in dictH.keys():
    outputFile = os.path.join("/home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST",
                              "latest_CONFIG", "conf_DATA", "users", key + ".json")
    with open(outputFile, "w") as f:
        json.dump(initDict, f, indent=4)
