//
//  JsonModel.m
//  JsonModel
//
//  Created by lvshouyi on 16/3/28.
//  Copyright © 2016年 lvshouyi. All rights reserved.
//

#import "JsonModel.h"
#import "NSJsonWindowController.h"
#import "NSSettingWindowController.h"
#import "NSHotKeyConfig.h"

@interface JsonModel()

@property (nonatomic,   strong, readwrite) NSBundle *bundle;
@property (nonatomic,   strong) NSJsonWindowController * window;
@property (nonatomic,   strong) NSSettingWindowController * settingWindow;
@property (nonatomic,   strong) NSMenuItem *actionMenuItem;

@end

@implementation JsonModel



+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillTerminate:) name:NSApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadMenu) name:HOTKEY_CHANGE object:nil];
    }
    return self;
}

- (void)applicationWillTerminate:(NSNotification *)notification
{

}

-(void)notificationListener:(NSNotification *)noti {
    NSLog(@" Notification: %@", [noti name]);
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"DS JsonModel" action:@selector(doMenuAction) keyEquivalent:@"J"];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
        self.actionMenuItem = actionMenuItem;
        [self reloadMenu];
        
        NSMenuItem *settingMenuItem = [[NSMenuItem alloc] initWithTitle:@"DS Setting" action:@selector(doSettingMenuAction) keyEquivalent:@""];
        [settingMenuItem setTarget:self];
        [[menuItem submenu]addItem:settingMenuItem];
        
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
    }
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    self.window = [[NSJsonWindowController alloc]initWithWindowNibName:@"NSJsonWindowController"];
    [self.window showWindow:self.window];
}

- (void)doSettingMenuAction
{
    self.settingWindow = [[NSSettingWindowController alloc]initWithWindowNibName:@"NSSettingWindowController"];
    [self.settingWindow showWindow:self.settingWindow];
}

- (void)reloadMenu
{
    
    [self.actionMenuItem setKeyEquivalentModifierMask:[NSHotKeyConfig getKeyModifiers]];
    [self.actionMenuItem setKeyEquivalent:[NSHotKeyConfig getKeyCode] ];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
