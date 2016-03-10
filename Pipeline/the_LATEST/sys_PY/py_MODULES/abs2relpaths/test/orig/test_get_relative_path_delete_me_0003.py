from relative_path_script_0003 import get_relative_path



def main():
    root = "C:/Users/SelecaoOne/Desktop/sandbox/relative_path_script/test/"
    file = "file_formats_test.ma"
    mayaFile = root + file
    otherFolder = "C:/Users/SelecaoOne/Desktop/"
    print get_relative_path(otherFolder, mayaFile)

main()
