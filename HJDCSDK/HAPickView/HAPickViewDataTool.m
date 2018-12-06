//
//  HAPickViewDataTool.m
//  HAFund
//
//  Created by hajjec01 on 2018/12/5.
//  Copyright © 2018 HAFUND. All rights reserved.
//

#import "HAPickViewDataTool.h"

@implementation HAPickViewDataTool
-(NSDictionary *)weekDict{
    return @{@"周一":@"1",@"周二":@"2",@"周三":@"3",@"周四":@"4",@"周五":@"5"};
}

-(NSArray *)monthArr{
    NSMutableArray * arr = [NSMutableArray array];
    
    NSMutableArray * keyList = [NSMutableArray array];
    for (int i = 1; i<29; i++) {
        [keyList addObject:[NSString stringWithFormat:@"%d日",i]];
    }
    NSMutableArray * valueList = [NSMutableArray array];
    for (int i = 1; i<29; i++) {
        [valueList addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [arr addObject:keyList];
    [arr addObject:valueList];
    return [arr copy];
}


+ (instancetype)instant{
    static HAPickViewDataTool *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HAPickViewDataTool alloc] init];
    });
    return manager;
}
//通过枚举类型获取选项数组
- (void)getPickListWithType:(PickType)type PickView:(HAPickView *)pickView DataCallBack:(nonnull void (^)(NSArray * , NSArray * , NSArray * , NSArray * ))callBack{
    if (type == MonthWeek ) {//选择每周 每两周  每月
        NSArray * list1 = @[@"每周",@"每两周",@"每月"];
        NSArray * list2 = self.weekDict.allKeys;
        pickView.pick1 = list1[0];
        pickView.pick2 = list2[0];
        callBack(list1,list2,nil,nil);
    }else if(type == SelectBirthDay){//选择生日
        DateModel * model = [self getNowDate];
        NSMutableArray * list1 = [NSMutableArray array];
        for(NSInteger i = model.Year-100;i<=model.Year;i++){
            [list1 addObject: [NSString stringWithFormat:@"%zd",i]];
        }
        NSMutableArray * list2 = [NSMutableArray array];
        for(NSInteger i = 1;i<13;i++){
            [list2 addObject: [NSString stringWithFormat:@"%02zd",i]];
        }
        NSMutableArray * list3 = [NSMutableArray array];
        for(NSInteger i = 1;i<[self getDaysInMonth:model.Year-100 month:model.Month];i++){
            [list3 addObject: [NSString stringWithFormat:@"%02zd",i]];
        }
        pickView.pick1 = [NSString stringWithFormat:@"%zd",model.Year];
        pickView.pick2 = [NSString stringWithFormat:@"%02zd",model.Month];
        pickView.pick3 = [NSString stringWithFormat:@"%02zd",model.Day];
        callBack(list1,list2,list3,nil);
        
    }else if (type == SelectDateZone){//选择时间区间内的时间
        DateModel * model = [self getNowDate];
        NSMutableArray * list1 = [NSMutableArray array];
        for(NSInteger i= pickView.startYear;i<= pickView.endYear;i++){
            [list1 addObject: [NSString stringWithFormat:@"%zd",i]];
        }
        NSMutableArray * list2 = [NSMutableArray array];
        for(NSInteger i = 1;i<13;i++){
            [list2 addObject: [NSString stringWithFormat:@"%02zd",i]];
        }
        NSMutableArray * list3 = [NSMutableArray array];
        for(NSInteger i = 1;i<[self getDaysInMonth:pickView.startYear month:model.Month];i++){
            [list3 addObject: [NSString stringWithFormat:@"%02zd",i]];
        }
        pickView.pick1 = [NSString stringWithFormat:@"%zd",model.Year];
        pickView.pick2 = [NSString stringWithFormat:@"%02zd",model.Month];
        callBack(list1,list2,list3,nil);
        
    }else if (type == SelectValidDay){//选择证件有效期
        DateModel * model = [self getNowDate];
        NSMutableArray * list1 = [NSMutableArray array];
        for(NSInteger i = model.Year ;i<=model.Year+20;i++){
            [list1 addObject: [NSString stringWithFormat:@"%zd",i]];
        }
        NSMutableArray * list2 = [NSMutableArray array];
        for(NSInteger i = 1;i<13;i++){
            [list2 addObject: [NSString stringWithFormat:@"%02zd",i]];
        }
        NSMutableArray * list3 = [NSMutableArray array];
        for(NSInteger i = 1;i<[self getDaysInMonth:model.Year month:model.Month];i++){
            [list3 addObject: [NSString stringWithFormat:@"%02zd",i]];
        }
        pickView.pick1 = [NSString stringWithFormat:@"%zd",model.Year];
        pickView.pick2 = [NSString stringWithFormat:@"%02zd",model.Month];
        pickView.pick3 = [NSString stringWithFormat:@"%02zd",model.Day];
        callBack(list1,list2,list3,nil);
    }else if (type == TerminationDate){//选择若干交易日内的日期
        //把下个交易日到截止日的日期去除周末 得到一个年月日数组
        NSMutableArray * dateList = [NSMutableArray array];
        for (NSInteger i =0; i<=pickView.TerminationDays; i++) {
            NSDate *date = [NSDate dateWithTimeInterval:i*24*60*60 sinceDate:pickView.nextTradeDay];//后一天
            if (![self isWeekendWithDate:date]) {//去除周末
                 DateModel * model = [self getModelWithDate:date];
                [dateList addObject:model];
            }
        }
        //拿到当前下一交易日的年到截止交易日的年
        NSMutableArray * list1 = [NSMutableArray array];
        for (NSInteger i = ((DateModel *)[self getModelWithDate:pickView.nextTradeDay]).Year ;i<=((DateModel *)[self getModelWithDate:[NSDate dateWithTimeInterval:pickView.TerminationDays*24*60*60 sinceDate:pickView.nextTradeDay]]).Year; i++) {
            [list1 addObject: [NSString stringWithFormat:@"%zd",i]];
        }
        //拿到下一交易日当前年的月份
        NSMutableArray * list2 = [NSMutableArray array];
        for (DateModel *model in dateList) {
            if (model.Year == ((DateModel *)[self getModelWithDate:pickView.nextTradeDay]).Year&&![list2 containsObject:[NSString stringWithFormat:@"%02ld",model.Month]]) {
                [list2 addObject: [NSString stringWithFormat:@"%02zd",model.Month]];
            }
        }
        //拿到下一交易日当前年当前月的天
        NSMutableArray * list3 = [NSMutableArray array];
        for (DateModel *model in dateList) {
            if (model.Year == ((DateModel *)[self getModelWithDate:pickView.nextTradeDay]).Year&&model.Month == ((DateModel *)[self getModelWithDate:pickView.nextTradeDay]).Month) {
                [list3 addObject: [NSString stringWithFormat:@"%02zd",model.Day]];
            }
        }
        callBack(list1,list2,list3,nil);
    }
}
//判断一个日期是否是周末
-(BOOL)isWeekendWithDate:(NSDate *)date{
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSInteger week = [[myCalendar components:NSCalendarUnitWeekday fromDate:date] weekday];
    if(week == 1||week == 7){
        return YES;
    }
    return NO;
}

//拿到任意一天的年月日
-(DateModel *)getModelWithDate:(NSDate *)date{
    DateModel * model = [DateModel new];;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    model.Year = [dateComponent year];
    model.Month = [dateComponent month];
    model.Day = [dateComponent day];
    return model;
}

//获取当前年月日
-(DateModel *)getNowDate{
    DateModel * model = [DateModel new];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    model.Year = [dateComponent year];
    model.Month = [dateComponent month];
    model.Day = [dateComponent day];
    return model;
}

//获取某年某月有多少天
- (NSInteger)getDaysInMonth:(NSInteger)year month:(NSInteger)imonth {
    // imonth == 0的情况是应对在CourseViewController里month-1的情况
    if((imonth == 0)||(imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}
@end

@implementation DateModel



@end
