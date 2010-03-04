#define TARGARCH arm
#define TARGARCH_ABI arm
#define TARGOPTIM release
#define ARM

CCFLAGS += -pipe -msoft-float -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -O2 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300 -g
ANDROID_ABI = armeabi
ANDROID_ARCH = arch-arm
ANDROID_GCC = arm-eabi-4.2.1
ANDROID_GCC_PREFIX = arm-eabi-
ANDROID_GCC_LIB = gcc/arm-eabi/4.2.1/interwork/libgcc.a

#include "android.inc"
