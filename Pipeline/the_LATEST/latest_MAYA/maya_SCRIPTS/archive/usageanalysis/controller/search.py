#!/usr/bin/env python

"""
Project::
 Portal Origins: Part Two
Description::
 Search is used to find superfluous files that are unneeded and message
 people to either delete, rename, or excempt the files
Author::
 Colin Kennedy
"""

def is_whitelisted():
    """
    Checks the file to see if it exists in the master whitelist.
    In the overall script, this is used as a check to make sure my writes
    aren't spamming people's inboxes with old files that they've already
    told me that they need to keep them there
    """
    pass
# end is_whitelisted


def main(folder):
    """
    -/ go through all files/folders/subfolders
    -/ filter to all ascii-based project files
    -/ parse them through and reference all possible source file extensions
    -/ if the parse brings back a file and the file is an extension that is
    meant to be checked (like I'll look for jpegs but nor for .raw)
     -/ check if the file being iterated exists
     -/ check the matched source file is absolute
     -/ if it is relative, search the path relative to that file's location
     -/ if the file is there, add it to a list of included files
    -/ after all files have been checked, compare the file list to the
    included file list
    -/ get intersection between lists
    -/ for every file in the remaining list of files that weren't used...
     -/ get username of every person from the file
     - create/append a dict for that file and assign it to the person's
     username as the dict's key
    - e-mail them with a list of file paths from that users's dict
    so they can easily manage them
     - remind them that they can use my tool to easily manage files if they
     want or go through them manually
    """
    allFolders = folder
    allFiles = []
    allProjectFiles = []
    allSrcFiles = []
    for root, dirs, files, in os.walk(onerror=None, followlinks=False):
        allFiles.append(os.path.join(root, files))

    allProjectFiles = [f for f in allFiles \
                       if allFiles.endswith(FILETYPES_ASCII)]
    allSourceFiles = [f for f in allFiles \
                       if allFiles.endswith(FILETYPES_SRC)]
    for file in allProjectFiles:
        if not os.path.isfile(file):
            continue  # skip iteration of current file

        with open(file) as f:
            data = [line.rstrip('\n') for line in f]

        for src in data:
            # determine if the source file is absolute, relative,
            # or exists in the current directory of the queried file
            if os.path.isabs(src):
                allSrcFiles.append(src)
            else:
                splitPathTemp = split_path(file)
                path = set_rel_path_to_abs_path(src, splitPathTemp[-1])
                if os.isfile(path):
                    allSrcFiles.append(path)
                else:
                    print('"{f}" was not a valid file'.format(f=path))



    allUnusedFiles = set(allFiles).symmetric_difference(set(allSrcFiles))

    if not allUnusedFiles:
        contactList = {}
        emailTemplate = os.path.join(os.environ['DEV_DIR'],
                                     'my_MESSAGES',
                                     'email_default_cleanup_message.txt')
        with open(emailTemplate) as f:
            emailTemplateData = [line.rstrip('\n') for line in f]

        for file in allUnusedFiles:
            # create a list of unused file paths from a particular user
            fileIO = FileIO(file)
            if fileIO.is_empty():
                print("The logger should write that the file is empty")

            user = fileIO.user
            if user in contactList:
                contactList.update({user: contactList[user].append(file)})
            else:
                contactList.update({user: [file]})

        for key, items in contactList.iteritems():
            # send email
            newEMail = emailTemplateData.replace('<<FILES>>', items)
            # send email

# end main

if __name__ == "__main__":
    main()
