//
//  NSData+HJDCEncrypt.h
//  HJDCSDK
//
//  Created by WangAn on 2018/5/29.
//

#import <Foundation/Foundation.h>

@interface NSData (HJDCEncrypt)
- (NSData *)AES256EncryptWithKey:(NSString *)key;

- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
