//
//  NSString+HJDCEncrypt.h
//  HJDCSDK
//
//  Created by WangAn on 2018/5/29.
//
//
//
//
//NSString 加/解密
#import <Foundation/Foundation.h>

@interface NSString (HJDCEncrypt)
/**
 获取MD5字符串
 @return MD5string
 */
- (NSString *)stringFromMD5;
/**
 3DES加密
 @param plainText String
 @return 加密后的String
 */
+ (NSString *)encrypt3DES:(NSString *)plainText;
/**
 3DES解密
 @param encryptText String
 @return 解密后的String
 */
+ (NSString *)decrypt3DES:(NSString*)encryptText;
@end
