//
//  NSString+HJDCTool.m
//  HJDCSDK
//
//  Created by WangAn on 2018/5/30.
//

#import "NSString+HJDCTool.h"
/*
 移动号段：
 134 135 136 137 138 139 147 148 150 151 152 157 158 159 172 178 182 183 184 187 188 198
 联通号段：
 130 131 132 145 146 155 156 166 171 175 176 185 186
 电信号段：
 133 149 153 173 174 177 180 181 189 199
 */
NSString * const MOBILE = @"^1(3[0-9]|4[5-9]|5[0-35-9]|66|7[1-8]|8[0-9]|99)\\d{8}$";
NSString * const MOBILEREGEXSTRING = @"1(3[0-9]|4[5-9]|5[0-35-9]|66|7[1-8]|8[0-9]|99)\\d{8}";
@implementation NSString (HJDCTool)
//是否为有效邮箱
- (BOOL)hjdc_isValidateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
//是否为有效手机号
-(BOOL)hjdc_isValidateMobileNumber {
    NSPredicate * regMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    return [regMobile evaluateWithObject:self];
}
//获取手机号范围
- (NSArray<NSValue *> *)hjdc_mobileNumberRange {
    NSMutableArray * ranges = @[].mutableCopy;
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:MOBILEREGEXSTRING options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray * matches = [regex matchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        [ranges addObject:[NSValue valueWithRange:matchRange]];
    }
    return ranges.copy;
}
@end
