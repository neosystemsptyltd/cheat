@echo off

set cc=cl
set warnings=/W4 ^
	/wd4100 /wd4127 /wd4702 /wd4996
set debug=%warnings% /Od /Zi
set deploy=/Ox
set cflags=%debug% ^
	/D__STDC_VERSION__=199409L ^
	/I.

if "%1" == "" goto :return
:continue
call :%1
shift
if "%1" == "" goto break
goto continue
:break
goto :eof
:return

:build
%cc% /nologo %cflags% ^
	/D__BASE_FILE__="""example.c""" /Feexample.exe example.c
%cc% /nologo %cflags% ^
	/D__BASE_FILE__="""examples.c""" /Feexamples.exe examples.c
goto :eof

:clean
del example.exe examples.exe
goto :eof

:test
example.exe
examples.exe
goto :eof
