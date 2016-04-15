//
//  SettingWindowController.m
//  JsonModel
//
//  Created by lvsy on 16/3/31.
//  Copyright © 2016年 lvshouyi. All rights reserved.
//


#import "NSSettingWindowController.h"
#import "NSHotKeyConfig.h"

typedef NS_ENUM(NSUInteger,key_type) {
    key_commond=1,
    key_shift ,
    key_option,
    key_control,
    
};

@interface NSSettingWindowController ()
@property (weak) IBOutlet NSButton *commandBtn;
@property (weak) IBOutlet NSButton *shiftBtn;
@property (weak) IBOutlet NSButton *optionBtn;
@property (weak) IBOutlet NSButton *controlBtn;

@end

@implementation NSSettingWindowController

- (void)windowDidLoad
{
    [super windowDidLoad];
	NSDictionary * HotKey = [NSHotKeyConfig hotKey];
	self.key.stringValue  = HotKey[kMenuHotKeyKey];
    
	NSNumber * hotKeyShift = HotKey[kMenuHotKeyMaskShift];
    [self.shiftBtn.cell setState:hotKeyShift.boolValue];
    
    NSNumber * hotKeyCmd = HotKey[kMenuHotKeyMaskCmd];
    [self.commandBtn.cell setState:hotKeyCmd.boolValue];
    
    NSNumber * hotKeyCtrl = HotKey[kMenuHotKeyMaskCtrl];
    [self.controlBtn.cell setState:hotKeyCtrl.boolValue];
    
    NSNumber * hotKeyOption = HotKey[kMenuHotKeyMaskAlt];
    [self.optionBtn.cell setState:hotKeyOption.boolValue];
    
}


- (IBAction)finshClick:(NSButton *)sender {
    
  
}


- (IBAction)clickCell:(NSButton *)sender {
    
    key_type type = sender.cell.tag;
    NSDictionary * defaultHotKey = [NSHotKeyConfig hotKey];
    NSMutableDictionary * HotKey = [NSMutableDictionary dictionaryWithDictionary:defaultHotKey];
    switch (type) {
        case key_shift: {
            [HotKey setValue:@(sender.cell.state) forKey:kMenuHotKeyMaskShift];
            break;
        }
        case key_option: {
            [HotKey setValue:@(sender.cell.state) forKey:kMenuHotKeyMaskAlt];
            break;
        }
        case key_control: {
            [HotKey setValue:@(sender.cell.state) forKey:kMenuHotKeyMaskCtrl];
            break;
        }
        case key_commond: {
            [HotKey setValue:@(sender.cell.state) forKey:kMenuHotKeyMaskCmd];
            break;
        }
    }
    [NSHotKeyConfig setHotKey:HotKey];
}

@end
