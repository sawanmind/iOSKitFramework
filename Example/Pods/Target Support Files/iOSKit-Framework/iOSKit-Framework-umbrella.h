#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "iOSKit_Framework.h"

FOUNDATION_EXPORT double iOSKit_FrameworkVersionNumber;
FOUNDATION_EXPORT const unsigned char iOSKit_FrameworkVersionString[];

