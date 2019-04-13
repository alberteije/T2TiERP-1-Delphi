#Enable this setting if you have problems starting the application 
#for example in suse 7.3 starting from a vncserver
#export CLX_USE_LIBQT=true
#Enable this setting if you have not defined the LANG variable in your system
#export LANG=en_US
#Bug fix in some distros need LC_NUMERIC en_US or print will not work
#That is to enable a bugfix, use it only if print does not work
export LC_NUMERIC=en_US
#Use this env.variables to override language locale
#export KYLIX_DEFINEDENVLOCALES=Yes
#export KYLIX_THOUSAND_SEPARATOR=.
#export KYLIX_DECIMAL_SEPARATOR=,
#export KYLIX_DATE_SEPARATOR=/
#export KYLIX_TIME_SEPARATOR=:
#You can share libraries copying libs to a directory
#for example /opt/kylixlibs and add the path to ld.so.conf
#then run ldconfig (as root)

# To enable kprinter dialog at preview
#export REPMANUSEKPRINTER=true
#export LD_ASSUME_KERNEL=2.4.21
export LD_LIBRARY_PATH=:$PWD:$LD_LIBRARY_PATH
./repmand $*
