Maya and Valgrind usage

Maya can be run under valgrind for memory errors/leaks.
The file maya.supp is a suppression file that can be used to help clean up
reported problems to focus on actual problems

The suppression entries for the Nvidia driver may need to be modified to match 
the version of driver installed


The .valgrindrc  file that can be used as a model  
some options are only valid for newer versions of valgrind, these were used
with Valgrind 3.9.0

 --tool=memcheck --vgdb=yes --db-attach=no --suppressions=/home/userName/maya.supp
 --error-limit=no --num-callers=40 --leak-check=yes --leak-resolution=high
 --show-reachable=yes --trace-children=no --log-file=/home/userName/val.%p.txt
 --malloc-fill=ac --free-fill=fe --track-origins=yes --read-var-info=yes
 --keep-stacktraces=alloc-then-free


The file will need to be customized for the actual user to specify where the
suppression file resides and where the log file is located.  Replace all
occurances of '/home/userName' with an appropriate directory

Valgrind 3.9.0  has been used with Maya

Included in this directory is a patch file val390-maya-patch.txt  which
includes a couple of changes for array sizes and debug warning messages from
Intel generated debug info

the patch should be able to be applied to the released Valgrind 3.9.0 source
or hand editted as needed


In order to run maya under valgrind, use the command line option

GUI mode:       maya -d valgrind
Prompt mode:    maya -d valgrind -prompt

where  valgrind is the command used to launch the version of valgrind wanted.
If you have built valgrind locally and installed it in say:  /opt/valgrind-390
suggest you create a symlink to the binary and use that

cd /usr/bin
ln -s /opt/valgrind-390/bin/valgrind /usr/bin/val390

can then run Maya as:   maya -d val390



For more information on Valgrind, see the web site: http://www.valgrind.org

