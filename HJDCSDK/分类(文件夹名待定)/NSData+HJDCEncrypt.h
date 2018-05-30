//
//  NSData+HJDCEncrypt.h
//  HJDCSDK
//
//  Created by WangAn on 2018/5/29.
//

#import <Foundation/Foundation.h>

@interface NSData (HJDCEncrypt)
/**
 AES256加密NSData
 @param key AES256 key
 @return 加密后的NSData
 */
- (NSData *)hjdc_AES256EncryptWithKey:(NSString *)key;
/**
 AES256解密NSData
 @param key AES256 key
 @return 解密后的NSData
 */
- (NSData *)hjdc_AES256DecryptWithKey:(NSString *)key;

@end
