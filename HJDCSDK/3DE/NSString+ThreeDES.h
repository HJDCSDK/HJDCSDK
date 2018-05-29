//
//  NSString+ThreeDES.h
//  3DE
//
//  Created by Brandon Zhu on 31/10/2012.
//  Copyright (c) 2012 Brandon Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ThreeDES)
/** 3DES 加密*/
+ (NSString *)encrypt3DES:(NSString *)plainText;
/** 3DES 解密 */
+ (NSString *)decrypt3DES:(NSString*)encryptText;
@end
