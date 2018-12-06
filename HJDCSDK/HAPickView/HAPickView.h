//
//  HAPickView.h
//  HAFund
//
//  Created by hajjec01 on 2018/12/5.
//  Copyright © 2018 HAFUND. All rights reserved.
//

#warning 该控件最大支持4列

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Null,
    /// 交易周期
    MonthWeek,
    /// 选择截止日期
    TerminationDate,
    /// 选择出生年月日
    SelectBirthDay,
    /// 选择证件有效日期
    SelectValidDay,
    /// 选择时间区段,例如交易记录的开始时间到结束时间
    SelectDateZone,
} PickType;

@interface HAPickView : UIView

@property(nonatomic,strong)NSString * pick1;//选中1
@property(nonatomic,strong)NSString * pick2;//选中2
@property(nonatomic,strong)NSString * pick3;//选中3
@property(nonatomic,strong)NSString * pick4;//选中4
@property(nonatomic,strong)NSArray * pickList1;//选项数组1
@property(nonatomic,strong)NSArray * pickList2;//选项数组2
@property(nonatomic,strong)NSArray * pickList3;//选项数组3
@property(nonatomic,strong)NSArray * pickList4;//选项数组4
@property(nonatomic,strong)NSString * title;//标题

//这两个参数查询收益时传递
//开始年份
@property(nonatomic,assign)NSInteger startYear;
//截止年份
@property(nonatomic,assign)NSInteger endYear;

//这两个参数用于选择接下来多少个交易日内的日期传递
//下一交易日
@property(nonatomic,strong)NSDate * nextTradeDay;
//截止天数
@property(nonatomic,assign)NSInteger TerminationDays;

/**
 通过传入类型的构造方法
 
 @param frame 视图坐标
 @param title 标题
 @param type 选择类型
 @param start 起始日期(type为TerminationDate传)
 @param end 截止日期(type为TerminationDate传)
 @param date 下一交易日(type为SelectDateZone传)
 @param days 下一交易日后多少天(type为SelectDateZone传)
 @param selectCallback 选择回调
 */
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Type:(PickType)type StartYear:(NSInteger)start EndYear:(NSInteger)end NextTradeDate:(NSDate *)date TerminationDays:(NSInteger)days selectCallBack:(void(^)(NSString *pick1,NSString*pick2,NSString*pick3,NSString*pick4))selectCallback;
/**
 通过传入数组的构造方法
 
 @param frame 视图坐标
 @param title 标题
 @param list1 第一列数组
 @param pick1 第一列默认选中项
 @param selectCallback 选择回调
 */
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title PickList1:(NSArray *)list1 pick1:(NSString *)pick1  selectCallBack:(void(^)(NSString *pick1,NSString*pick2,NSString*pick3,NSString*pick4))selectCallback;
/**
 通过传入数组的构造方法
 
 @param frame 视图坐标
 @param title 标题
 @param list1 第一列数组
 @param pick1 第一列默认选中项
 @param list2 第二列数组
 @param pick2 第二列默认选中项
 @param selectCallback 选择回调
 */
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title PickList1:(NSArray *)list1 pick1:(NSString *)pick1 PickList2:(NSArray *)list2 pick2:(NSString *)pick2  selectCallBack:(void(^)(NSString *pick1,NSString*pick2,NSString*pick3,NSString*pick4))selectCallback;
/**
 通过传入数组的构造方法
 
 @param frame 视图坐标
 @param title 标题
 @param list1 第一列数组
 @param pick1 第一列默认选中项
 @param list2 第二列数组
 @param pick2 第二列默认选中项
 @param list3 第三列数组
 @param pick3 第三列默认选中项
 @param selectCallback 选择回调
 */
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title PickList1:(NSArray *)list1 pick1:(NSString *)pick1 PickList2:(NSArray *)list2 pick2:(NSString *)pick2 PickList3:(NSArray *)list3 pick3:(NSString *)pick3 selectCallBack:(void(^)(NSString *pick1,NSString*pick2,NSString*pick3,NSString*pick4))selectCallback;
/**
 通过传入数组的构造方法
 
 @param frame 视图坐标
 @param title 标题
 @param list1 第一列数组
 @param pick1 第一列默认选中项
 @param list2 第二列数组
 @param pick2 第二列默认选中项
 @param list3 第三列数组
 @param pick3 第三列默认选中项
 @param list4 第四列数组
 @param pick4 第四列默认选中项
 @param selectCallback 选择回调
 */
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title PickList1:(NSArray *)list1 pick1:(NSString *)pick1 PickList2:(NSArray *)list2 pick2:(NSString *)pick2 PickList3:(NSArray *)list3 pick3:(NSString *)pick3 PickList4:(NSArray *)list4 pick4:(NSString *)pick4 selectCallBack:(void(^)(NSString *pick1,NSString*pick2,NSString*pick3,NSString*pick4))selectCallback;
@end
