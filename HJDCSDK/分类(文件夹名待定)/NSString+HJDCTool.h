//
//  NSString+HJDCTool.h
//  HJDCSDK
//
//  Created by WangAn on 2018/5/30.
//

#import <Foundation/Foundation.h>

@interface NSString (HJDCTool)
/**
 是否为有效邮箱
 @return YES/NO
 */
- (BOOL)hjdc_isValidateEmail;
/**
 判断手机号是否有效
 @return YES/NO
 */
- (BOOL)hjdc_isValidateMobileNumber;
/**
 查找字符串中的手机号范围
 @return 手机号Range
 */
- (NSArray<NSValue*>*)hjdc_mobileNumberRange;
@end
