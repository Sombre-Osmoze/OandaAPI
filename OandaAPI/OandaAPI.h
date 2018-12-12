//
//  OandaAPI.h
//  OandaAPI
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

#if TARGET_OS_OSX

#import <Cocoa/Cocoa.h>

//! Project version number for OandaAPI.
FOUNDATION_EXPORT double OandaAPIVersionNumber;

//! Project version string for OandaAPI.
FOUNDATION_EXPORT const unsigned char OandaAPIVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <OandaAPI/PublicHeader.h>

#elif TARGET_OS_IOS

#import <UIKit/UIKit.h>

//! Project version number for OandaAPI_iOS.
FOUNDATION_EXPORT double OandaAPI_iOSVersionNumber;

//! Project version string for OandaAPI_iOS.
FOUNDATION_EXPORT const unsigned char OandaAPI_iOSVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <OandaAPI_iOS/PublicHeader.h>

#elif TARGET_OS_WATCH

#import <WatchKit/WatchKit.h>

//! Project version number for OandaAPI_WatchOS.
FOUNDATION_EXPORT double OandaAPI_WatchOSVersionNumber;

//! Project version string for OandaAPI_WatchOS.
FOUNDATION_EXPORT const unsigned char OandaAPI_WatchOSVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <OandaAPI_WatchOS/PublicHeader.h>


#endif
