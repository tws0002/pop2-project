#!/usr/bin/python


dictH = {
    "SUDO": {
        "USERNAME": "SUDO",
        "USERFULLNAME": "Admin Guest",
        "PHONENUMBER": [
            0,
            0,
            0
        ],
        "EMAIL": "noemail@example.com"
    },
    "danger20": {
        "USERNAME": "danger20",
        "USERFULLNAME": "David Anger",
        "PHONENUMBER": [
			310,
			749,
			2741
        ],
        "EMAIL": "anger.david@gmail.com",
        "PLUGIN_BLACKLIST": {
            "nuke": [
                "tabtabtab"
            ]
        }
    },
    "korinkite": {
        "USERNAME": "korinkite",
        "USERFULLNAME": "Colin Kennedy",
        "PHONENUMBER": [
            203,
            722,
            6620
        ],
        "EMAIL": "colinvfx@gmail.com"
    },

    "selecaotwo": {
        "USERNAME": "selecaotwo",
        "USERFULLNAME": "Colin Kennedy",
        "PHONENUMBER": [
            203,
            722,
            6620
        ],
        "EMAIL": "colinvfx@gmail.com"
    },
    "ckenne24": {
        "USERNAME": "ckenne24",
        "USERFULLNAME": "Colin Kennedy",
        "PHONENUMBER": [
            203,
            722,
            6620
        ],
        "EMAIL": "colinvfx@gmail.com"
    },
    "mmcmul21": {
        "USERNAME": "mmcmul21",
        "USERFULLNAME": "Michael McMullan",
        "PHONENUMBER": [
            770,
            689,
            7512
        ],
        "EMAIL": "mike@msmmotionpictures.com",
        "TITLE": "Writer/Director/VFX Supervisor"
    },
    "yincui20": {
        "USERNAME": "yincui20",
        "USERFULLNAME": "Yingnan Cui (Kate)",
        "PHONENUMBER": [
			912,
			484,
			8191
        ],
        "EMAIL": "cynkate33@gmail.com",
        "TITLE": "Modeling"
    },
    "jpasqual": {
            "USERNAME": "jpasqual",
            "USERFULLNAME": "Joe Pasqual",
            "PHONENUMBER": [
                912,
                525,
                8511
                ],
            "EMAIL": "jpasqual@scad.edu",
            "TITLE": "Studio Teacher"
            }
}



import json

filename = r"/home/ckenne24/mount/collaborative/portal-origins-part-2/Pipeline/2015_01_19_Build/latest_CONFIG/conf_INFO/crew_sheet.json"
filename = r"/home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST/latest_CONFIG/conf_DATA/crew_sheet.json"
with open(filename, "w") as f:
	json.dump(dictH, f, indent=4)
