# CoreMake USAGE DOCUMENTATION
                     
## INTRODUCTION
CoreMake is a meta-makefile processor that turns .proj files into makefiles
for various compilers/IDE, including Visual Studio, MSVC6 , EVC4 , XCode
kdevelop, GNU make, nmake, Carbide.

Unlike other meta-makefile processors, CoreMake doesn't need a scripting
language to run. It's just a .c file that needs to be compiled and some
scripts that it will interpret. The default values for each compiler are meant
to produce valid and optimized code.


## LICENSE
CoreMake is a tool developped by CoreCodec, Inc. under the BSD license.


## GETTING STARTED
coremake.c needs to be compiled before using coremake. On Windows, with Visual
Studio you can use the following command to get coremake.exe :
  cl.exe coremake.c

On Linux/OS X/Mingw you can generate it using :
  gcc -o coremake coremake.c

Once you have the CoreMake executable you need to run it from the root of your
source code :
  coremake vs_2005

At present, the default XCode SDK does not support arm64.  This may lead to 
the error "error: Unsupported architecture" when attempting to compile.
If this occurs, select the XCode beta with the following command:

  `sudo xcode-select -s /Applications/Xcode-beta.app/Contents/Developer`
  
You can then build coremake as normal using `gcc -o coremake coremake.c`.

This command will generate the project files to compile your source in Visual
Studio 2005 for Windows on x86. Each target is located in the coremake directory
with a .build file extension. See Apendix A for a list of target names and
their corresponding use.


## .PROJ FILES

### Directories
CoreMake uses .proj files to define what workspace and projects to build. There
should be only one .proj file per directory and the name of the .proj file should
be the name of the directory. With the exception of root.proj which can be in
the root of your source directory.

  <src root>/root.proj
  <src root>/directory/directory.proj
  <src root>/otherdir/otherdir.proj

From within a .proj you have to declare what subdirectory CoreMake should scan.
If this is not done, subdirectories are not used. For example root.proj could 
have this:
  #include "directory/directory.proj"

Or more generally:
  #include "*/*.proj"
  
As the coremake folder (and all it's .build files) are generally not where the
source code is, it is possible to tell in root.proj where the coremake folder
is located:
  PLATFORM_FILES tools/coremake

When building a coremake'd project the object files (.o or .obj) are generated
in the <root>/build/<target> directory. And the result of the build is put
in the <root>/release/<target> directory. For example:
  <root>/build/vs_2005/test.o
  <root>/release/vs_2005/test.exe


### Syntax
A .proj file is just a text file that describes the projects to create and the
source/libraries to use. All folders should use the '/' character and never
the DOS/Windows '\' character.

There are different types of definitions in CoreMake:
- WORKSPACE lists all the projects that the makefile/solution will contain
- EXE, CON, DLL, LIB are actual projects that will result in file to compile
  and link, all written in C, C++ or Assembler
- EXE_CSHARP, CON_CSHARP, DLL_CSHARP, LIB_CSHARP are actual projects but
  written in the C# language
- GROUP can list the same things as a regular project but don't result in
  a project to build. It can be included in many other projects where the
  content of the GROUP will be added (like an include file or a template)


### Use command
To add a project into a WORKSPACE you have to use the USE command:
  EXE test
  {
    SOURCE test.c
  }
  
  WORKSPACE TestWorkspace
  {
    USE test
  }

That USE command is also used to include the content of a GROUP or add compilation
and linking dependencies between projects (an EXE using a DLL for example).

In this example "test" use the fileHandler.dll (or .so) that will be compiled
before "test" when building the solution "TestWorkspace":
  DLL fileHandler
  {
    SOURCE file.c
  }
  
  EXE test
  {
    SOURCE test.c
    USE fileHandler
  }
  
  WORKSPACE TestWorkspace
  {
    USE test
  }
  
The order in which the WORKSPACE, EXE, DLL, GROUP, etc are placed in the .proj
files is not important. But each project should have a unique name in all the
.proj files found.


### Libraries & Headers
Any regular C program usually has to include some headers and use the 
corresponding libraries. The headers and libraries can be in some specific
location. The syntax to add such directories is the following:
  DLL fileHandler
  {
    SOURCE file.c
    INCLUDE path/to/headers
    LIBINCLUDE path/to/library
  }
  
To add a library for linking the syntax is as follows:
  DLL fileHandler
  {
    SOURCE file.c
    LIBS a_library.lib
    LIBINCLUDE path/to/library
  }


## Apendix A: list of targets

| Name | Notes |
| ---- | ------|
| Name | Notes |
| ---- | ------|
| android_arm64 | Android ARM 64 bits |
| android_armv5 |
| android_armv6 |
| android_armv7 |
| android_armv7_hardfp |  Arm v7 with Hard Floating Point unit |
| android_x86 |
| clean | clean the files generated by coremake |
| distclean | clean the files generated by coremake and built |
| evc_arm |  Windows CE ARM target built with MS EVC 4.0 |
| evc_arm_pocketpc |  Pocket PC ARM target built with MS EVC 4.0 |
| evc_arm_smartphone |  Smartphone ARM target built with MS EVC 4.0 |
| evc_armv4 |  Windows CE ARM target built with MS EVC 4.0 |
| evc_armv4_pocketpc |  Pocket PC ARMv4 target built with MS EVC 4.0 |
| evc_armv4_smartphone |  Pocket PC ARMv4 target built with MS EVC 4.0 |
| evc_armv4i |  Windows CE ARMv4i target built with MS EVC 4.0 |
| evc_emulator |  Windows CE emulator target built with MS EVC 4.0 |
| evc_mips |  Windows CE MIPS target built with MS EVC 4.0 |
| evc_mipsii |  Windows CE MIPSII target built with MS EVC 4.0 |
| evc_sh3 |  Windows CE SH3 target built with MS EVC 4.0 |
| evc_sh4 |  Windows CE SH4 target built with MS EVC 4.0 |
| evc_x86 |  Windows CE x86 target built with MS EVC 4.0 |
| evc_x86em |  Windows CE x86 Emulator target built with MS EVC 4.0 |
| gcc_linux |
| gcc_linux_arm |
| gcc_linux_debug |
| gcc_linux_ppc |
| gcc_linux_qt_x86 |
| gcc_linux_x64 |
| gcc_linux_x64_debug |
| gcc_osx |
| gcc_osx_iphone_dev |
| gcc_osx_ppc |
| gcc_osx_x64 |
| gcc_osx_x64_appstore | GCC build for OSX x64, which use the SDK installed from the AppStore |
| gcc_osx_x86 |
| gcc_osx_x86_appstore | GCC build for OSX x86, which use the SDK installed from the AppStore |
| gcc_osx_x86_pic |
| gcc_palmos |
| gcc_ps2sdk |
| gcc_qtcore_arm |
| gcc_qtcore_x86 |
| gcc_qtphone_arm |
| gcc_qtphone_x86 |
| gcc_sparc32 |
| gcc_sparc64 |
| gcc_win32 | Windows 32bits on x86 built with MinGW+MSys |
| gcc_x_win32 | Windows 32bits on x86 built with MinGW+MSys as a cross compiler |
| icl_2005 |
| kdevelop |
| kdevelop_qtcore_arm_debug |
| kdevelop_qtphone_arm |
| kdevelop_qtphone_arm_debug |
| kdevelop_qtphone_x86 |
| kdevelop_qtphone_x86_debug |
| s60_1st |
| s60_1st_wins |
| s60_2nd_fp3 |
| s60_2nd_fp3_debug |
| s60_2nd_fp3_winscw |
| s60_3rd_fp1 |
| s60_3rd_fp1_debug |
| s60_3rd_fp1_winscw |
| s60_3rd_mr |
| s60_3rd_mr_debug |
| s60_3rd_mr_winscw |
| s80_dp2 |
| s80_dp2_wins |
| s90_7710 |
| s90_7710_wins |
| uiq_21 |
| uiq_21_wins |
| uiq_30 |
| uiq_30_debug |
| uiq_30_winscw |
| uiq_31 |
| uiq_31_winscw |
| vc6 | Windows 32bits on x86 built with MS Visual C++ 6 |
| vc6_palmos |
| vs_2003 | Windows 32bits on x86 built with MS Visual Studio 2003 |
| vs_2005 | Windows 32bits on x86 built with MS Visual Studio 2005 |
| vs_2008 | Windows 32bits on x86 built with MS Visual Studio 2008 |
| vs_ce5_armv4i |
| vs_ce5_mipsii |
| vs_express | Windows 32bits on x86 built with MS Visual C++ Express |
| vs_ppc2003_armv4 |
| vs_smart2003_armv4 |
| vs_wm5_armv4i |
| vs_wm5s_armv4i |
| vs_wm6p_armv4i |
| vs_wm6s_armv4i |
| vs_x64 | Windows 64bits on x64 built with MS Visual Studio 2005 |
| xcode_ios | iOS build for devices (except i386 for the simu) |
| xcode_ios_simu| iOS i386 version to use with the simulator |
| xcode_macosx |
