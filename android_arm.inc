#define TARGARCH arm
#define TARGARCH_ABI arm
#define TARGOPTIM release
#define ARM

CCFLAGS += -pipe -msoft-float -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -O2 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300 -fvisibility=hidden -g
SFLAGS += -march=armv7-a -D_HIDDEN

ANDROID_ARCH = arch-arm
ANDROID_GCC_PREFIX = arm-eabi
ANDROID_GCC_VERSION = 4.4.3
ANDROID_GCC = %(ANDROID_GCC_PREFIX)-%(ANDROID_GCC_VERSION)
ANDROID_GCC_LIB = gcc/%(ANDROID_GCC_PREFIX)/%(ANDROID_GCC_VERSION)/libgcc.a
ANDROID_TOOL_DIR = %(ANDROID_GCC)

#include "android.inc"
