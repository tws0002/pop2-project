Constants - |project_long_name| 
*********************************
Constants is one of the first files that are ever run in the environment and is
Used in nearly every module throughout the project. It contains the following:
 - System-specific data and configuration settings
 - Project-specific data, folder structures, and configurations
 - File/Folder naming conventions
 - A current list of supported applications in the environment
 - Crew information and contact information
 - User-level settings including, the person's personal settings, their 
   preferences and also their access-level in the project
 - Any other misc environment variables necessary to run the system

On Execution
====================
When constants first starts up, it initializes the logger that is used for
in all of the other tools and begins checking user-based information
such as their project registration information, file/folder permissions,
applications, and other "initial access" checks.
Once that checks out, constants reaches EOF and the user can sign in.

Module Details
===================
Although constants is firstly a project-configuration tool, it serves
other purposes as well with its module variables, the way it expects 
incoming environment variables as well as its use in defining the 
naming conventions for the project.

Module Variables
----------------------
CONFIG_DIR 
The directory that contains a variety of configuration info
- It contains data about the project folder structure
- crew sheet information
- supported applications
- all of the application start-up scripts
- Maya's default project location when sharing over the network

Environment Variables
---------------------------
Currently, the environment directly expects the following environment variables, 

Required environment variables: 
 - ADMIN_MODE
 - LOG_LEVEL 
 - PIPELINE_DIR
 - PROJECT_DIR

Optional environment variables:
 - APP_EXECUTABLE
 - SOLIDARITY
 - USER_OVERRIDE
 - PLAY_SOUNDS

These variables are all set in the .sh/.bat files that I gave to the team 
I'm sure that in the future, there will be more variables than what I may have
remembered to list here

LOG_LEVEL
+++++++++++++
Determines how verbose the project's logger will be when it's performing
its operations. The logger incurs a few seconds per frame upon render and
so, if speed is a consideration, the user has the ability to change how much 
the logger outputs

Recommended Use: Always keep LOG_LEVEL at "debug" or high in verbosity
as possible. If the number of messages is a problem, move the LOG_LEVEL to 
"info", "warning", "error", or "critical"

PROJECT_DIR
+++++++++++++
This environment variable is assigned at the user level, so that they can
work off-network if necessary. By default, PROJECT_DIR points to our network 
storage solution at its root directory (hence why PROJECT_DIR is renamed to 
ROOT_DIR in constants)

Recommended Use: Never change unless you are a dev

PIPELINE_DIR
+++++++++++++
Along the same lines as PROJECT_DIR, except this is the root directory
for pipeline TDs and anyone working on scripts for the project. 

ADMIN_MODE
+++++++++++++
When written as explictly stated as "On", ADMIN_MODE overwrites the current 
user and gives them an admin guest account. This may be considered a security 
risk but I've found it useful to have when I was troublshooting other 
people's files. I'm not sure if making this will come back to bite me but
I can always just disable the feature if it becomes a problem

USER_OVERRIDE
+++++++++++++++++
Specify a username to log in as on the current project. Useful for troubleshooting.

SOLIDARITY
+++++++++++++
Currently, there's a rudimentary system in place to allow users to opt-out of
certain plugins and features. If they'd like to disable that and restore a 
"default" configuration, they should set this value to True

APP_EXECUTABLE
++++++++++++++++++
The actual binary/executable file that will be run in order to start 
the application. This environment variable is checked on start-up against 
the production's list of allowed applications

PLAY_SOUNDS
++++++++++++++
Plays music on startup of applications. Usually, it's a quick Seinfeld bass 
riff. It's kind of fun and I also use it to make sure that a script ran all
the way through to completion without any errors.


Project Specific
=====================
The overall name conventions for folders come from two sets of config files.
The first file is a JSON file that contains the PROJECT_DIR and any relevant
file(s)/folder(s) as a nested dictionary. Each key/value has a parsed text
name. The second config file contains key-item pairs that basically fill in
information from the first configuration file. 

If a folder must change its location or its name, I need only swap the name 
and/or location in the dictionary. When constants loads, it performs a 
number of operations assuming that these folders exist.  Using this structure,
we have the ability to test if folder(s)/file(s) were successfully created.

- In a future release I'll be able to get the directory back from the dict and
require that the directory/file exists otherwise it will exit the application.

Project Documentation
==========================
There are several variables that point it files and web URL addresses, meant
to educate the user on how to use the file naming convention and folders. 
Here is a quick list of a few:

- BUG_REPORT_PAGE
- FEATURE_REQUEST_PAGE
- WELCOME_PAGE
- FILE_NAMING_CONVENTION_PAGE
