//
//  NSHotKeyConfig.h
//  JsonModel
//
//  Created by lvshouyi on 16/4/5.
//  Copyright © 2016年 lvshouyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMenuTitle           @"title"
#define kMenuHotKey          @"HotKey"
#define kMenuHotKeyKey       @"key"
#define kMenuHotKeyMask      @"mask"
#define kMenuHotKeyMaskAlt   @"alt"
#define kMenuHotKeyMaskCmd   @"cmd"
#define kMenuHotKeyMaskCtrl  @"ctrl"
#define kMenuHotKeyMaskShift @"shift"

#define kSettingFile         @"setting"

@interface NSHotKeyConfig : NSObject

+ (void)setHotKey:(NSDictionary *)hotKey;

+ (NSDictionary *)hotKey;

+ (void)addHotKey;
+ (void)removeHotKey;
@end
