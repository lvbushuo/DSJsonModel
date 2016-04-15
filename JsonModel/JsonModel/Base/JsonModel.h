//
//  JsonModel.h
//  JsonModel
//
//  Created by lvshouyi on 16/3/28.
//  Copyright © 2016年 lvshouyi. All rights reserved.
//

#import <AppKit/AppKit.h>

@class JsonModel;

static JsonModel *sharedPlugin;

@interface JsonModel : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end