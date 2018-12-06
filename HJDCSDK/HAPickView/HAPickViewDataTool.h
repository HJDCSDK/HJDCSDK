//
//  HAPickViewDataTool.h
//  HAFund
//
//  Created by hajjec01 on 2018/12/5.
//  Copyright © 2018 HAFUND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HAPickView.h"
@class DateModel;
@interface HAPickViewDataTool : NSObject
@property(nonatomic,strong)NSDictionary * weekDict;
@property(nonatomic,strong)NSArray * monthArr;

+ (instancetype)instant;

-(void)getPickListWithType:(PickType)type PickView:(HAPickView *)pickView DataCallBack:(void(^)(NSArray * ,NSArray *,NSArray *,NSArray *))callBack;

//获取某年某月有多少天
- (NSInteger)getDaysInMonth:(NSInteger)year month:(NSInteger)imonth;
//判断一个日期是否是周末
-(BOOL)isWeekendWithDate:(NSDate *)date;
//拿到任意一天的年月日
-(DateModel *)getModelWithDate:(NSDate *)date;
@end

@interface DateModel : NSObject

@property(nonatomic,assign)NSInteger Year;//年
@property(nonatomic,assign)NSInteger Month;//月
@property(nonatomic,assign)NSInteger Day;//日
@end
