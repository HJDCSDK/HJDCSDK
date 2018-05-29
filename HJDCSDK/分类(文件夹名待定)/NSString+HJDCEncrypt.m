//
//  NSString+HJDCEncrypt.m
//  HJDCSDK
//
//  Created by WangAn on 2018/5/29.
//

#import "NSString+HJDCEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

#define gIv  @"01234567"
#define kSecrectKeyLength 24
@implementation NSString (HJDCEncrypt)
- (NSString *)stringFromMD5 {
    if (self.length == 0) {
        return nil;
    }
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (uint32_t)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return outputString;
}
#pragma mark 加密
+ (NSString *)encrypt3DES:(NSString *)plainText{
    //获取当前日期
    
    NSString * keyDate = [self acquireDate];
    
    //拼接key并进行3DES加密
    NSString * key = [NSString stringWithFormat:@"%@_@YZFPadWeb2015",keyDate];
    return [self encrypt:plainText withKey:key];
}

#pragma mark 解密
+ (NSString *)decrypt3DES:(NSString*)encryptText{
    //获取当前日期
    NSString * keyDate = [self acquireDate];
    
    //拼接key并进行3DES解密
    NSString * key = [NSString stringWithFormat:@"%@_@YZFPadWeb2015",keyDate];
    return [self decrypt:encryptText withKey:key];
}

#pragma mark 获取时间
+ (NSString *)acquireDate{
    NSDate * date = [NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    return [dateformatter stringFromDate:date];
}

#pragma 加密算法
+ (NSString*)encrypt:(NSString*)plainText withKey:(NSString*)key{
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    return result;
}

#pragma 解密算法
+ (NSString*)decrypt:(NSString*)encryptText withKey:(NSString*)key{
    
    NSData *encryptData = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    return result;
}


- (NSString*) sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
@end
