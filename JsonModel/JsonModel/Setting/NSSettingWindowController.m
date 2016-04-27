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
@property (strong)NSMutableDictionary * hotKey;
@end

@implementation NSSettingWindowController

- (void)windowDidLoad
{
    [super windowDidLoad];
	self.hotKey = [NSMutableDictionary dictionaryWithDictionary:[NSHotKeyConfig hotKey]];
	self.key.stringValue  = self.hotKey[kMenuHotKeyKey];
    
	NSNumber * hotKeyShift = self.hotKey[kMenuHotKeyMaskShift];
    [self.shiftBtn.cell setState:hotKeyShift.boolValue];
    
    NSNumber * hotKeyCmd = self.hotKey[kMenuHotKeyMaskCmd];
    [self.commandBtn.cell setState:hotKeyCmd.boolValue];
    
    NSNumber * hotKeyCtrl = self.hotKey[kMenuHotKeyMaskCtrl];
    [self.controlBtn.cell setState:hotKeyCtrl.boolValue];
    
    NSNumber * hotKeyOption = self.hotKey[kMenuHotKeyMaskAlt];
    [self.optionBtn.cell setState:hotKeyOption.boolValue];
    
}


- (IBAction)finshClick:(NSButton *)sender {
    
      [NSHotKeyConfig setHotKey:self.hotKey];
}


- (IBAction)clickCell:(NSButton *)sender {
    
    key_type type = sender.cell.tag;
 
    switch (type) {
        case key_shift: {
            [self.hotKey setValue:@(sender.cell.state) forKey:kMenuHotKeyMaskShift];
            break;
        }
        case key_option: {
            [self.hotKey setValue:@(sender.cell.state) forKey:kMenuHotKeyMaskAlt];
            break;
        }
        case key_control: {
            [self.hotKey setValue:@(sender.cell.state) forKey:kMenuHotKeyMaskCtrl];
            break;
        }
        case key_commond: {
            [self.hotKey setValue:@(sender.cell.state) forKey:kMenuHotKeyMaskCmd];
            break;
        }
    }

}

#pragma mark - NSTextFieldDelegate
- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor
{
    NSString * text = self.key.stringValue;
    if (text) {
        [self.hotKey setObject:text forKey:kMenuHotKeyKey];
    }
    return YES;
}
@end
