import os

def conform_paths(rootPath, absPath):
    if len(absPath.split('/')) != 1:
        rootPath = rootPath.replace("\\", "/")
        rootPath = rootPath.replace("\\\\", "/")
    elif len(absPath.split('\\')) != 1:
        rootPath = rootPath.replace("/", "\\")
        rootPath = rootPath.replace("\\\\", "\\")
    elif len(absPath.split('\\\\')) != 1:
        rootPath = rootPath.replace("/", "\\\\")
        rootPath = rootPath.replace("\\", "\\\\")

    return rootPath
# end conform_paths

def get_relative_path(rootPath, absPath):
    """
    - attempt to subtract the rootPath as a substring of absPath
     - if failure, attempt to search for the correct path
    """
    if rootPath == absPath:
        return absPath

    # conform the rootpath to the absolutepath, in case there are differences
    rootPath = conform_paths(rootPath, absPath)

    # os.sep assumes your OS, so it can't be used for this script
    # if an IT adminwas checking a Maya file with absolute paths made
    # by an artist in Windows while running Linux, the script would fail
    #
    # we must make our own rules for separators

    if '/' in absPath:
        pathSep = '/'
    elif '\\' in absPath:
        pathSep = '\\'
    else:
        pathSep = '\\\\'

    outputPath = ""
    if rootPath in absPath:
        absLength = absPath.split(pathSep)
        absLength = [x for x in absLength if x != '']
        absLength = len(absLength)
        rootLength = rootPath.split(pathSep)
        rootLength = [x for x in rootLength if x != '']
        rootLength = len(rootLength)


        lookBack = absLength - rootLength-1
        for _ in xrange(lookBack):
            outputPath += "..{}".format(pathSep)
        reducedPath = absPath[len(rootPath):]
        outputPath = outputPath + reducedPath

        # lazy cleanup
        outputPath = outputPath.replace('/', pathSep)
        outputPath = outputPath.replace('//', pathSep)
        outputPath = outputPath.replace('\\', pathSep)
        outputPath = outputPath.replace('\\\\', pathSep)
        return outputPath


    pathBreak = absPath.split(pathSep)
    backtrack = 1

    while backtrack != len(pathBreak):
        lookBack = len(pathBreak) - 1 - backtrack
        pathNew = (pathSep).join(pathBreak[0:lookBack])

        if pathNew in rootPath:
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
    help(get_relative_path)

if __name__ == "__main__":
    main()
