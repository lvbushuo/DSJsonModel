//
//  NSHotKeyConfig.m
//  JsonModel
//
//  Created by lvshouyi on 16/4/5.
//  Copyright © 2016年 lvshouyi. All rights reserved.
//

#import "NSHotKeyConfig.h"
#import <AppKit/AppKit.h>

NSString * const DSJsonModelHotKey = @"DSJsonModelHotKey";

@implementation NSHotKeyConfig

+ (void)setHotKey:(NSDictionary *)hotKey{
    NSDictionary * oldhotKey = [self hotKey];
    if (![oldhotKey isEqualToDictionary:hotKey]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:hotKey forKey:DSJsonModelHotKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter]postNotificationName:HOTKEY_CHANGE object:nil];
    }
}

+ (NSDictionary *)hotKey
{
    NSDictionary * HotKey = [[NSUserDefaults standardUserDefaults] dictionaryForKey:DSJsonModelHotKey];
    if (!HotKey) {
        HotKey = @{
                  kMenuHotKeyMaskShift:@(YES),
                  kMenuHotKeyMaskAlt:@(YES),
                  kMenuHotKeyMaskCtrl:@(NO),
                  kMenuHotKeyMaskCmd:@(NO),
                  kMenuHotKeyKey:@"j"
                  };
        [[NSUserDefaults standardUserDefaults] setObject:HotKey forKey:DSJsonModelHotKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return HotKey;
}

+ (NSUInteger)getKeyModifiers
{
    NSUInteger keyModifiers = 0;
    NSDictionary * dic = [self hotKey];
    NSNumber * hotKeyCmd = dic[kMenuHotKeyMaskCmd];
    keyModifiers = !hotKeyCmd.boolValue?keyModifiers :(keyModifiers | NSCommandKeyMask);
    
    NSNumber * hotKeyOption = dic[kMenuHotKeyMaskAlt];
    keyModifiers = !hotKeyOption.boolValue?keyModifiers :(keyModifiers | NSAlternateKeyMask);
    
    NSNumber * hotKeyShift = dic[kMenuHotKeyMaskShift];
    keyModifiers = !hotKeyShift.boolValue?keyModifiers :(keyModifiers | NSShiftKeyMask);
    
    NSNumber * hotKeyCtrl = dic[kMenuHotKeyMaskCtrl];
    keyModifiers = !hotKeyCtrl.boolValue?keyModifiers :(keyModifiers | NSControlKeyMask);
    
    return keyModifiers;
}

+ (NSString *)getKeyCode{
    NSString * keyCode = [self hotKey] [kMenuHotKeyKey];
    return keyCode.uppercaseString;
}

@end
