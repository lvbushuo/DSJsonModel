//
//  NSJsonWindowController.m
//  JsonModel
//
//  Created by lvshouyi on 16/3/29.
//  Copyright © 2016年 lvshouyi. All rights reserved.
//

#import "NSJsonWindowController.h"
#import "JMGHeaderGen.h"
#import "JMGImplGen.h"


#define DESKTOP_PATH    [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) firstObject]

@interface NSJsonWindowController ()

@property (weak) IBOutlet NSTextFieldCell *textField;
@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation NSJsonWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    self.textView.selectedRange = NSMakeRange(0, 0);
}
- (IBAction)generate:(id)sender {
    
    NSString *text = self.textView.textStorage.string;
    NSString *fileName = self.textField.stringValue;
    if ([text isEqualToString:@""] ||
        [fileName isEqualToString:@""]) {
        return ;
    }
    
    JMGHeaderGen *headerGen = [JMGHeaderGen new];
    NSString *header = [headerGen parseJSONString:text name:@"" root:fileName];
    NSString *headerFileName = [fileName stringByAppendingString:@".h"];
    [self saveToFile:header fileName:headerFileName];
    
    JMGImplGen *implGen = [JMGImplGen new];
    NSString *impl = [implGen parseJSONString:text name:@"" root:fileName];
    NSString *implFileName = [fileName stringByAppendingString:@".m"];
    [self saveToFile:impl fileName:implFileName];
    
    NSURL *folderURL = [NSURL fileURLWithPath:DESKTOP_PATH];
    [[NSWorkspace sharedWorkspace] openURL:folderURL];
}

- (void)saveToFile:(NSString *)string fileName:(NSString *)fileName {
    NSString *path = [DESKTOP_PATH stringByAppendingPathComponent:fileName];
    [string writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
@end
