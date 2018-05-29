//
//  NSString+HJDCEncrypt.m
//  HJDCSDK
//
//  Created by WangAn on 2018/5/29.
//

#import "NSString+HJDCEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
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
@end
