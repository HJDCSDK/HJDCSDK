//
//  NSString+HJDC.h
//  HJDC
//
//  Created by FuYunLei on 2018/5/29.
//  Copyright © 2018年 FuYunLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HJDC)

/**
 cache目录
 
 @return path
 */
+ (NSString *)hjdc_cacheDir;

/**
 doc目录
 
 @return path
 */
+ (NSString *)hjdc_docDir;
/**
 temp目录
 
 @return path
 */
+ (NSString *)hjdc_tempDir;

/**
 将当前字符串拼接到cache目录后面

 @return path
 */
- (NSString *)hjdc_cacheDir;

/**
 将当前字符串拼接到doc目录后面
 
 @return path
 */
- (NSString *)hjdc_docDir;
/**
 将当前字符串拼接到temp目录后面
 
 @return path
 */
- (NSString *)hjdc_tempDir;

@end
