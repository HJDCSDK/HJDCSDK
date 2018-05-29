//
//  NSString+HJDC.m
//  HJDC
//
//  Created by FuYunLei on 2018/5/29.
//  Copyright © 2018年 FuYunLei. All rights reserved.
//

#import "NSString+HJDC.h"

@implementation NSString (HJDC)

+ (NSString *)hjdc_cacheDir{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return path;
}
+ (NSString *)hjdc_docDir{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return path;
}
+ (NSString *)hjdc_tempDir{
    NSString *path = NSTemporaryDirectory();
    return path;
}

- (NSString *)hjdc_cacheDir{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return [path stringByAppendingPathComponent:self];
}
- (NSString *)hjdc_docDir{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return [path stringByAppendingPathComponent:self];
}
- (NSString *)hjdc_tempDir{
    NSString *path = NSTemporaryDirectory();
    return [path stringByAppendingPathComponent:self];
}

@end
