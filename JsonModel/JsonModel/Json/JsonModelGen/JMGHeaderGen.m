//
//  JMGHeaderGen.m
//  JsonModelGen
//
//  Created by cyan on 15/9/3.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "JMGHeaderGen.h"

NSString *Dict(NSString *typeName, NSString *name) {
    return [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;\n", typeName, name];
}

NSString *GenericArray(NSString *protocolName, NSString *name) {
    return [NSString stringWithFormat:@"@property (nonatomic, strong) NSMutableArray<%@> *%@;\n", protocolName, name];
}

NSString *Array(NSString *name) {
    return [NSString stringWithFormat:@"@property (nonatomic, strong) NSMutableArray *%@;\n", name];
}

NSString *String(NSString *name) {
    return [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;\n", name];
}

NSString *Int(NSString *name) {
    return [NSString stringWithFormat:@"@property (nonatomic, assign) int %@;\n", name];
}

NSString *Double(NSString *name) {
    return [NSString stringWithFormat:@"@property (nonatomic, assign) double %@;\n", name];
}

@interface JMGHeaderGen()

@end

@implementation JMGHeaderGen

- (NSString *)parseJSONString:(NSString *)text name:(NSString *)name root:(NSString *)root {
    NSDictionary *json = [text objectFromJSONString];
    if (!json) {
        NSLog(@"Error, JSON not found.");
        return nil;
    }
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yy/M/d";
    NSString *date = [fmt stringFromDate:[NSDate new]];
    NSString *prefix = [NSString stringWithFormat:@"//\n//  %@.h\n//  JsonModelGen\n//\n//  Created by JsonModelGen on %@.\n//  Copyright (c) 2015年 cyan. All rights reserved.\n//\n\n#import <Foundation/Foundation.h>", root, date];
    NSString *code = [self parseJSONObject:json name:name rootName:root];
    return [prefix stringByAppendingString:code];
}

- (NSString *)parseJSONObject:(NSDictionary *)json name:(NSString *)name rootName:(NSString *)rootName {
    __block NSMutableString *code = [NSMutableString stringWithFormat:@"\n\n@interface %@ : NSObject\n\n", [NSString stringWithFormat:@"%@%@", rootName, name]];
    rootName = [rootName stringByAppendingString:name];
    NSMutableArray *subJsonKeys = [NSMutableArray array];
    NSMutableArray *subArrayKeyValues = [NSMutableArray array];
    
    [json enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *typeName = [NSString stringWithFormat:@"%@%@", rootName, [key capitalizedString]];
            [code appendString:Dict(typeName, key)];
            [subJsonKeys addObject:key];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSString *protocolName = [NSString stringWithFormat:@"%@%@", rootName, [key capitalizedString]];
            id firstNode = [obj firstObject];
            if ([firstNode isKindOfClass:[NSDictionary class]]) {
                [code appendString:GenericArray(protocolName, key)];
                [subArrayKeyValues addObject:@{ key: firstNode }];
            } else {
                [code appendString:Array(key)];
            }
        } else if ([obj isKindOfClass:[NSString class]]) {
            [code appendString:String(key)];
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            if ([[obj description] containsString:@"."]) {
                [code appendString:Double(key)];
            } else {
                [code appendString:Int(key)];
            }
        }
    }];

    [code appendString:@"\n@end\n"];
    // subJson
    [subJsonKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        id obj = json[key];
        [code insertString:[self parseJSONObject:obj name:key.capitalizedString rootName:rootName] atIndex:0];
    }];
    // subArray
    [subArrayKeyValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *key = [[obj allKeys] firstObject];
        id value = [obj objectForKey:key];
        [code insertString:[self parseJSONObject:value name:key.capitalizedString rootName:rootName] atIndex:0];
        // protocol
        [code insertString:[NSString stringWithFormat:@"\n\n@protocol %@%@\n@end\n", rootName, key.capitalizedString] atIndex:0];
    }];
    
    return code;
}

@end
