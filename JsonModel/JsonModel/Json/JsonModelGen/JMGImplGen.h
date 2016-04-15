//
//  JMGImplGen.h
//  JsonModelGen
//
//  Created by cyan on 15/9/3.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

@interface JMGImplGen : NSObject

- (NSString *)parseJSONString:(NSString *)text name:(NSString *)name root:(NSString *)root;

@end
