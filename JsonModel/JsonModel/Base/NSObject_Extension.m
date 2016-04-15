//
//  NSObject_Extension.m
//  JsonModel
//
//  Created by lvshouyi on 16/3/28.
//  Copyright © 2016年 lvshouyi. All rights reserved.
//


#import "NSObject_Extension.h"
#import "JsonModel.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[JsonModel alloc] initWithBundle:plugin];
        });
    }
}
@end
