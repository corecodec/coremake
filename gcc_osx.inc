#define TARGET_OSX

#define OUTPUT_EXE     %(NAME)
#define OUTPUT_CON     %(NAME)
#define OUTPUT_DLL     lib%(NAME).dylib
#define OUTPUT_DLL_LIB lib%(NAME).lo
#define OUTPUT_LIB     lib%(NAME).a

#define ASM yasm
#define NASM nasm
IFNDEF STRIP
#define STRIP %(CC_PREFIX)strip
ENDIF
#define STRIPFLAGS -x

#define GLIBC

IF %(SDK)
  CCFLAGS = %(CCFLAGS) -isysroot %(SDK)
ENDIF
IF %(SYSLIB_ROOT)
  LFLAGS= -Wl,-syslibroot,%(SYSLIB_ROOT)
ELIF %(SDK)
  LFLAGS= -isysroot %(SDK) -Wl,-syslibroot,%(SDK)
ENDIF

CCFLAGS = %(CCFLAGS) -pipe -O3 -fvisibility=hidden
IF %(SDK_PATH)
  CCFLAGS = -I%(SDK_PATH)/include %(CCFLAGS)
ENDIF
//#define ASMFLAGS -f elf32
//#define LFLAGS
//#define LDFLAGS -Wl,-dynamic,-search_paths_first
//#define FFSLDFLAGS -Wl,-bind_at_load

#ifdef PIC
#define SHFLAGS -dynamiclib -Wl,-single_module -Wl,-install_name,%(OUTPUT_DLL)
#else
#define SHFLAGS -dynamiclib -Wl,-read_only_relocs,suppress -Wl,-single_module -Wl,-install_name,%(OUTPUT_DLL)
#endif

#include "gcc.inc"
