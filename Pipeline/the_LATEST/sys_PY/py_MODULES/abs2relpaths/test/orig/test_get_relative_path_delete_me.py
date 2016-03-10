import os

def conform_paths(rootPath, absPath):

    if absPath.find("/") and rootPath.find("/"):
        rootPath = rootPath.replace("\\", "/")
    elif absPath.find("\\") and rootPath.find("\\"):
        rootPath = rootPath.replace('/', "\\")

    return rootPath
# end conform_paths

def get_relative_path(rootPath, absPath):
    """
    - attempt to subtract the rootPath as a substring of absPath
     - if failure, attempt to search for the correct path
    """
    # conform the rootpath to the absolutepath, in case there are differences
    rootPath = conform_paths(rootPath, absPath)

    # os.sep assumes your OS, so it can't be used for this script
    # if an IT adminwas checking a Maya file with absolute paths made
    # by an artist in Windows while running Linux, the script would fail
    #
    # we must make our own rules for separators
    if absPath.find('/'):
        pathSep = '/'
    elif absPath.find('\\'):
        pathSep = '\\\\'
    else:
        pathSep = '\\'

    if rootPath in absPath:
        outputPath = absPath[len(rootPath)+1:]
        return outputPath

    pathBreak = absPath.split(pathSep)
    # backtrack = len(pathBreak - 1)
    backtrack = 1
    outputPath = ""

    while backtrack != len(pathBreak):
        lookBack = len(pathBreak) - 1 - backtrack
        pathNew = (pathSep).join(pathBreak[0:lookBack])
        print pathNew
        if pathNew in absPath:
            for _ in xrange(backtrack):
                outputPath += "..{}".format(pathSep)
            reducedPath = rootPath[len(pathNew)+1:]

            outputPath = outputPath + reducedPath
            return outputPath
        else:
            backtrack += 1

    return False  # if the script did not find a solution, it is false
# end get_relative_path

def main():
    # test for an exact match. Should return as config.py
    #
    #
    absPath = "C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/"\
              "config.py"
    rootPath = 'C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/'

    # test if I can search and get the result ../license_script/__init__.py
    absPath = "C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/config.py"
    rootPath = "C:\Users\SelecaoOne\Desktop\sandbox\license_script\__init__.py"

    # test a far off location
    absPath = "C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/config.py"
    rootPath = "C:\Users\Public"
    # test a failing condition
    # absPath = "asdfasdfsd"
    # rootPath = "goodeats.jpeg"

    newPath = get_relative_path(rootPath, absPath)
    print newPath
main()
