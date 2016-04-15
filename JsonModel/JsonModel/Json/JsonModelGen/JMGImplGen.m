//
//  JMGImplGen.m
//  JsonModelGen
//
//  Created by cyan on 15/9/3.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "JMGImplGen.h"

NSMutableString *Impl(NSString *name) {
    return [[NSString stringWithFormat:@"\n\n@implementation %@\n\n@end\n", name] mutableCopy];
}

@implementation JMGImplGen

- (NSString *)parseJSONString:(NSString *)text name:(NSString *)name root:(NSString *)root {
    NSDictionary *json = [text objectFromJSONString];
    if (!json) {
        NSLog(@"Error, JSON not found.");
        return nil;
    }
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yy/M/d";
    NSString *date = [fmt stringFromDate:[NSDate new]];
    NSString *prefix = [NSString stringWithFormat:@"//\n//  %@.m\n//  JsonModelGen\n//\n//  Created by JsonModelGen on %@.\n//  Copyright (c) 2015年 cyan. All rights reserved.\n//\n\n#import \"%@.h\"", root, date, root];
    NSString *code = [self parseJSONObject:json name:name rootName:root];
    return [prefix stringByAppendingString:code];
}

- (NSString *)parseJSONObject:(NSDictionary *)json name:(NSString *)name rootName:(NSString *)rootName {
    __block NSMutableString *code = Impl([NSString stringWithFormat:@"%@%@", rootName, name]);
    rootName = [rootName stringByAppendingString:name];

    NSMutableArray *subArrayKeyValues = [NSMutableArray array];
    
    [json enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [code insertString:[self parseJSONObject:obj name:key.capitalizedString rootName:rootName] atIndex:0];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            id firstNode = [obj firstObject];
            if ([firstNode isKindOfClass:[NSDictionary class]]) {
                [subArrayKeyValues addObject:@{ key: firstNode }];
            }
        }
    }];
    
    // subArray
    [subArrayKeyValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *key = [[obj allKeys] firstObject];
        id value = [obj objectForKey:key];
        [code insertString:[self parseJSONObject:value name:key.capitalizedString rootName:rootName] atIndex:0];
    }];
    
    return code;
}

@end
