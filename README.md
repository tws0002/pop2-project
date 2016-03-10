# Portal: Origins [Part 2] Environment
[Portal: Origins [Part 2]](https://www.kickstarter.com/projects/msmmotionpictures/portal-origins-part-2) is a Senior Studio short film that is currently in
production at SCAD (Savannah College of Art and Design). The
Pipeline/the_LATEST folder contains the entire pipeline. All other folders are
included simply to make the pipeline deployable so that hooks and directory
references are less likely to fail.

## On Using
Currently, the pipeline was built mainly for Maya and Nuke. At SCAD, where
users who are not administrators don't have basic permissions for setting
users/groups/sym-links etc., I had to come up with a workaround. I was also
didn't have an admin account at SCAD so the way that I got around not being
able to set environment variables was to create .bat (Windows)/.sh (Linux)
files for every application that we needed to use. Even basic users can set
variables on execution so it seemed like the best way to do it at the time. All
of the .sh files used in the project are located under
[conf_SCRIPTS](Pipeline/the_LATEST/latest_CONFIG/conf_SCRIPTS) and, at the start of the
project, I gave out the files to everyone in the group so, whenever there was a
new update to the pipeline, all the user needs to do is restart their program
and it'll source the the_LATEST and all of its files.

## On Developing
At any given time in the project, I keep one folder for the_LATEST and another
for the_LATESTDEV. When changes were ready from one environment, I backup
the_LATEST, notify everyone in our project messenger client about the change on
slack.com, and move the_LATESTDEV so that everyone gets the new changes. The
best times to sync files is Tuesday morning after 1:30AM, in my experience.

## User Registration
Only people who are registered in the environment can use the tools within it.
That way, no one from outside of the production will use and potentially break
the tools or any of our software.

Currently, registration is done through a simple .json file located at
*"Pipeline/the_LATEST/latest_CONFIG/conf_DATA/crew_sheet.json"* but in the
future, we'd like to switch to a Google docs sheet to make the process a bit
more secure. Additionally, each user has a config file under the convention of
*"Pipeline/the_LATEST/latest_CONFIG/conf_DATA/users/$USER.json"* where $USER is
their username on the Windows/Linux system. Once both criteria are filled, the
user can now start working within the environment

## Application Registration Support
Any program that must be run is checked against a list of allowed applications
for the given project. If the file doesn't exist in the list, the environment
exits, forcing people to move to the next version (We had issues with people
not wanting to get off of Maya 2015). The file in question is located at
*"Pipeline/the_LATEST/latest_CONFIG/supportedApplications.json"*

## Misc. Offline Configuration Data
In *"Pipeline/the_LATEST/latest_CONFIG/conf_DATA/project_config.json"*, there
are the names of files/folders that the environment sources into constants.py
whenever an application within the environment starts up.

### Misc. Offline Configuration Data Future Improvements
I'd like to replace this file and all hard-coding with a .json file that can
read in as a self-referential dictionary, so that the pipeline could be modular
and adjust more easily to changes in the folder/file structure

## Notable Files/Modules
### constants.py
Located in
*"Pipeline/the_LATEST/sys_PY/py_MODULES/constants/model/constants.py"*, this
file initializes the logger which is used for nearly every application in the
environment, as well as checks for user registration, application registration,
and hard-codes many environment variables. Later on in development,
constants.py was also used to interpret variables being passed in from the
.bat/.sh files as well. This module ties together the environment, as a whole.

### checkout.py
Located in
*"Pipeline/the_LATEST/sys_PY/py_MODULES/fileio/controller/checkout.py"*,
checkout.py is used to validate the lock/edit status of files over the SCAD's
*"collaborative space"* network. In short, since there's no way to guarantee
that two or more people aren't both editing or revising the same file at once,
checkout.py governs file usage and tracks who is opening what file.

#### checkout.py Implementation
When a user opens a file, a ".lock" version of the file is created with the
user's information. When they close the scene file, the ".lock" is deleted.
Whenever someone tries to open a file, the system checks for a ".lock" version
of the file and, if one exists, the user is locked out and they are given a
display of who is using it, what room/machine number they're in (so you can go
talk to them, if needed) as well as they contact info.

checkout.py also has an additional role, which is to contain methods for
checking the scene file itself as the user is saving. If the file doesn't
properly match our regex match patterns or has bad geometry etc etc, the save
is canceled until the user makes the necessary changes. In general this feature
is used very sparingly - I only stop a save if the user tries to do something
that would break our renders or the environment.

#### checkout.py Additional Note
Originally, I had it in my mind that I would need to subclass out the
FileCheckout class for each application but, as it turns out, that wasn't
necessary at all. I left the other classes for
FileCheckoutMaya/FileCheckoutNuke/FileCheckoutHoudini but none of them are
implemented in the pipeline. More on that in the manager.py section

### manager.py
Located in
*"Pipeline/the_LATEST/sys_PY/py_MODULES/fileio/controller/manager.py"*, the
manager.py is the actual implementation of the save/open/close methods for
files over the network. Notice - the module is written in pure Python. (Note: I
originally had it in my head to use application-specific modules here so
there's some left-over methods but the methods that don't use Maya/Nuke/Houdini
modules are the ones that were implemented). (:AUTHORNOTE: Remove this note
later after I've cleaned up this module).

This function raises custom errors that are defined in the globerror.py module
to determine various actions that the script should take. For example, raising
IOValidationError will cause the script to exit prematurely and in

mayamanager.py (*"Pipeline/the_LATEST/latest_MAYA/maya_SCRIPTS"*)

nukemanager.py (*"Pipeline/the_LATEST/latest_NUKE/nuke_SCRIPTS"*)

houmanager.py (*"Pipeline/the_LATEST/latest_HOU/hou_SCRIPTS"*)

all have methods that use try/except to catch the exception while the function
is executing and then, depending on whether or not manager.py instructs the
applications to allow or fail a save, will then use application-specific
methods for handling that error. This way, instead of subclassing for each
application, the system is kept granular at the application level and coded
in pure-python at the implementation level

manager.py also has a few methods for querying data over SCAD's network, which
are all hosted in network.py in
*"Pipeline/the_LATEST/sys_PY/py_MODULES/network/controller/network.py"*.
Everything that requires communication with the network is placed here.

## More Info
This page is a broad breakdown for the pipeline however a more detailed
documentation on the environment's structure and specifics on individual files
can be found at my website's documentation page
[colinvfx.com/pop2-administration](http://colinvfx.com/wp-content/themes/thesis/docs/wip/administration.html)
