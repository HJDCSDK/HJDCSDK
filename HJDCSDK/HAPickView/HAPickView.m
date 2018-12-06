//
//  HAPickView.m
//  HAFund
//
//  Created by hajjec01 on 2018/12/5.
//  Copyright © 2018 HAFUND. All rights reserved.
//

#import "HAPickView.h"
#import "HAPickViewDataTool.h"
typedef void(^selectCall)(NSString*,NSString*,NSString*,NSString*);

@interface HAPickView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong) UIPickerView * pickView;
@property(nonatomic,copy)selectCall callBack;
@property(nonatomic,assign)PickType pickViewType;

@end

@implementation HAPickView
//根据类型创建
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Type:(PickType)type StartYear:(NSInteger)start EndYear:(NSInteger)end NextTradeDate:(NSDate *)date TerminationDays:(NSInteger)days selectCallBack:(void(^)(NSString *pick1,NSString*pick2,NSString*pick3,NSString*pick4))selectCallback{
    if ([super initWithFrame:frame]) {
        _pickViewType = type;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        _callBack = selectCallback;
        _startYear = start;
        _endYear = end;
        _nextTradeDay = date;
        _TerminationDays = days;
        
        [[HAPickViewDataTool instant] getPickListWithType:type PickView:self DataCallBack:^(NSArray * list1, NSArray * list2, NSArray *list3, NSArray *list4) {
            _pickList1 = list1;
            _pickList2 = list2;
            _pickList3 = list3;
            _pickList4 = list4;
        }];
        _title = title;
        [self createUI];
    }
    return self;
}
//一个选项卡的
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title PickList1:(NSArray *)list1 pick1:(NSString *)pick1  selectCallBack:(void(^)(NSString *pick1,NSString*pick2,NSString*pick3,NSString*pick4))selectCallback{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        _pickList1 = list1;
        _pick1 = pick1;
        _title = title;
        _callBack = selectCallback;
        [self createUI];
    }
    return self;
}
//两个选项卡的
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title PickList1:(NSArray *)list1 pick1:(NSString *)pick1 PickList2:(NSArray *)list2 pick2:(NSString *)pick2  selectCallBack:(void(^)(NSString *pick1,NSString*pick2,NSString*pick3,NSString*pick4))selectCallback{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        _pickList1 = list1;
        _pickList2 = list2;
        _pick1 = pick1;
        _pick2 = pick2;
        _title = title;
        _callBack = selectCallback;
        [self createUI];
    }
    return self;
}
// 三个选项数组的
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title PickList1:(NSArray *)list1 pick1:(NSString *)pick1 PickList2:(NSArray *)list2 pick2:(NSString *)pick2 PickList3:(NSArray *)list3 pick3:(NSString *)pick3 selectCallBack:(void (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))selectCallback{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        _pickList1 = list1;
        _pickList2 = list2;
        _pickList3 = list3;
        _pick1 = pick1;
        _pick2 = pick2;
        _pick3 = pick3;
        _title = title;
        _callBack = selectCallback;
        [self createUI];
    }
    return self;
}
//四级菜单选项组的
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title PickList1:(NSArray *)list1 pick1:(NSString *)pick1 PickList2:(NSArray *)list2 pick2:(NSString *)pick2 PickList3:(NSArray *)list3 pick3:(NSString *)pick3 PickList4:(NSArray *)list4 pick4:(NSString *)pick4 selectCallBack:(void(^)(NSString *pick1,NSString*pick2,NSString*pick3,NSString*pick4))selectCallback{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        _pickList1 = list1;
        _pickList2 = list2;
        _pickList3 = list3;
        _pickList4 = list4;
        _pick1 = pick1;
        _pick2 = pick2;
        _pick3 = pick3;
        _pick4 = pick4;
        _title = title;
        _callBack = selectCallback;
        [self createUI];
    }
    return self;
}
-(void)createUI{
    //容器View
   UIView * containerView = [UIView viewWithColor:[UIColor whiteColor] frame:CGRectZero superView:self constraintMaker:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-KBOTTOMHEIGHT);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kSCREEN_MY_WIDTH(200));
    }];
    //标题View
    UIView * titleView = [UIView viewWithColor:[UIColor orangeColor] frame:CGRectZero superView:containerView constraintMaker:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kSCREEN_MY_WIDTH(40));
    }];
    //取消按钮
    [UIButton buttonTitle:@"取消" frame:CGRectZero font:14 titleColor:[UIColor blueColor] imageName:nil backgroundImge:nil target:self action:@selector(cancel) superView:titleView constraintMaker:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(titleView);
    }];
    //确定按钮
    [UIButton buttonTitle:@"确定" frame:CGRectZero font:14 titleColor:[UIColor blueColor] imageName:nil backgroundImge:nil target:self action:@selector(sureClick) superView:titleView constraintMaker:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(titleView);
    }];
    [UILabel labelWithTitle:_title titleColor:[UIColor blackColor] font:14 frame:CGRectZero superView:titleView constraintMaker:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(titleView);
    }];
    //pickView
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectZero];
    _pickView.delegate = self;
    _pickView.dataSource = self;
    [containerView addSubview:_pickView];
    [_pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [self configDefaultSelect];//配置默认选中项
}
-(void)configDefaultSelect{
    if(_pickList1 != NULL&&_pickList1.count>0){
        [_pickView selectRow:[self getRowWithPick:_pick1 PickList:_pickList1] inComponent:0 animated:NO];
    }
    if(_pickList2 != NULL&&_pickList2.count>0){
        [_pickView selectRow:[self getRowWithPick:_pick2 PickList:_pickList2]  inComponent:1 animated:NO];
    }
    if(_pickList3 != NULL&&_pickList3.count>0){
        [_pickView selectRow:[self getRowWithPick:_pick3 PickList:_pickList3]  inComponent:2 animated:NO];
    }
    if(_pickList4 != NULL&&_pickList4.count>0){
        [_pickView selectRow:[self getRowWithPick:_pick4 PickList:_pickList4]  inComponent:3 animated:NO];
    }
}
-(NSInteger)getRowWithPick:(NSString *)str PickList:(NSArray *)list{
    if ([list containsObject:str]) {
      return  [list indexOfObject:str];
    }
    return 0;
}
#pragma mark-----Action
-(void)cancel{
    NSLog(@"取消");
    [self removeFromSuperview];
}
-(void)sureClick{
    NSLog(@"确定----回调结果");
    if(_callBack){
        _callBack(_pick1,_pick2,_pick3,_pick4);
    }
    [self removeFromSuperview];
}
#pragma mark--------UIPickViewDelegate
//返回每列有多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return _pickList1.count;
            break;
        case 1:
            return _pickList2.count;
            break;
        case 2:
            return _pickList3.count;
            break;
        case 3:
            return _pickList4.count;
            break;
        default:
            return 0;
            break;
    }
}
//返回列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_pickList2 != NULL)
    {
        if (_pickList3 != NULL)
        {
            if (_pickList4 != NULL)
            {
                return 4;
            }
            else {
                return 3;
            }
        }
        else {
            return 2;
        }
    }
    else {
        return 1;
    }
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel * pickLabel =  [UILabel labelWithTitle:@"" titleColor:[UIColor blackColor] font:14 frame:CGRectZero superView:nil constraintMaker:nil];
    NSString * itemStr = @"请选择";
    switch (component) {
        case 0:
            itemStr = _pickList1[row];
            break;
        case 1:
            itemStr = _pickList2[row];
            break;
        case 2:
            itemStr = _pickList3[row];
            break;
        case 3:
            itemStr = _pickList4[row];
            break;
        default:
            break;
    }
    pickLabel.text = itemStr;
    [pickLabel sizeToFit];
    pickLabel.textAlignment = NSTextAlignmentCenter;
    return pickLabel;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return kSCREEN_MY_WIDTH(30);
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _pick1 = _pickList1[row];
        if (_pickViewType == MonthWeek) {// 是选择每周或每两周
            if([_pick1 isEqualToString:@"每周"]||[_pick1 isEqualToString:@"每两周"]){
                _pickList2 = [HAPickViewDataTool instant].weekDict.allKeys;
                if ([pickerView selectedRowInComponent:1]>_pickList2.count-1) {
                    _pick2 = [_pickList2 lastObject];
                }else{
                    _pick2 = _pickList2[[pickerView selectedRowInComponent:1]];
                }
            }else{
                _pickList2 = [HAPickViewDataTool instant].monthArr[0];
                _pick2 = _pickList2[[pickerView selectedRowInComponent:1]];
            }
            [pickerView reloadComponent:1];
        }else if (_pickViewType == SelectBirthDay||_pickViewType == SelectValidDay||_pickViewType == SelectDateZone){
            NSInteger days = [[HAPickViewDataTool instant] getDaysInMonth:[_pick1 integerValue] month:[_pick2 integerValue]];
            NSMutableArray * list = [NSMutableArray array];
            for (NSInteger i = 1; i<=days; i++) {
                [list addObject:[NSString stringWithFormat:@"%02zd",i]];
            }
            if (days == _pickList3.count) {
                return;
            }
            if ([pickerView selectedRowInComponent:2]>list.count-1) {
                _pick3 = [list lastObject];
            }else{
                _pick3 = list[[pickerView selectedRowInComponent:2]];
            }
            _pickList3 = list;
             [pickerView reloadComponent:2];
        }else if (_pickViewType == TerminationDate){
            //把下个交易日到截止日的日期去除周末 得到一个年月日数组
            NSMutableArray * dateList = [NSMutableArray array];
            for (NSInteger i =0; i<=_TerminationDays; i++) {
                NSDate *date = [NSDate dateWithTimeInterval:i*24*60*60 sinceDate:_nextTradeDay];//后一天
                if (![[HAPickViewDataTool instant] isWeekendWithDate:date]) {//去除周末
                    DateModel * model = [[HAPickViewDataTool instant] getModelWithDate:date];
                    [dateList addObject:model];
                }
            }
            NSMutableArray * monthList = [NSMutableArray array];
            for (DateModel * model in dateList) {
                if (model.Year == [_pick1 integerValue]&&![monthList containsObject:[NSString stringWithFormat:@"%02zd",model.Month]]) {
                    [monthList addObject:[NSString stringWithFormat:@"%02zd",model.Month]];
                }
            }
            if ([pickerView selectedRowInComponent:1]>monthList.count-1) {
                _pick2 = [monthList lastObject];
            }else{
                _pick2 = monthList[[pickerView selectedRowInComponent:1]];
            }
            _pickList2 = monthList;
            [pickerView reloadComponent:1];
            
            NSMutableArray * dayList = [NSMutableArray array];
            for (DateModel * model in dateList) {
                if (model.Year == [_pick1 integerValue]&&model.Month == [_pick2 integerValue]) {
                    [dayList addObject:[NSString stringWithFormat:@"%02zd",model.Day]];
                }
            }
            if ([pickerView selectedRowInComponent:2]>monthList.count-1) {
                _pick3 = [dayList lastObject];
            }else{
                _pick3 = dayList[[pickerView selectedRowInComponent:2]];
            }
            _pickList3 = dayList;
            [pickerView reloadComponent:2];
        }
    }else if (component ==1){
        _pick2 = _pickList2[row];
        if (_pickViewType == SelectBirthDay||_pickViewType == SelectValidDay||_pickViewType == SelectDateZone){
            NSInteger days = [[HAPickViewDataTool instant] getDaysInMonth:[_pick1 integerValue] month:[_pick2 integerValue]];
            NSMutableArray * list = [NSMutableArray array];
            for (NSInteger i = 1; i<=days; i++) {
                [list addObject:[NSString stringWithFormat:@"%02zd",i]];
            }
            if (days == _pickList3.count) {
                return;
            }
            if ([pickerView selectedRowInComponent:2]>list.count-1) {
                _pick3 = [list lastObject];
            }else{
                _pick3 = list[[pickerView selectedRowInComponent:2]];
            }
            _pickList3 = list;
            [pickerView reloadComponent:2];
            
        }else if (_pickViewType == TerminationDate){
            //把下个交易日到截止日的日期去除周末 得到一个年月日数组
            NSMutableArray * dateList = [NSMutableArray array];
            for (NSInteger i =0; i<=_TerminationDays; i++) {
                NSDate *date = [NSDate dateWithTimeInterval:i*24*60*60 sinceDate:_nextTradeDay];//后一天
                if (![[HAPickViewDataTool instant] isWeekendWithDate:date]) {//去除周末
                    DateModel * model = [[HAPickViewDataTool instant] getModelWithDate:date];
                    [dateList addObject:model];
                }
            }
            NSMutableArray * dayList = [NSMutableArray array];
            for (DateModel * model in dateList) {
                if (model.Year == [_pick1 integerValue]&&model.Month == [_pick2 integerValue]) {
                    [dayList addObject:[NSString stringWithFormat:@"%02zd",model.Day]];
                }
            }
            if (_pickList3.count == dayList.count) {
                return;
            }
            if ([pickerView selectedRowInComponent:2]>dayList.count-1) {
                _pick3 = [dayList lastObject];
            }else{
                _pick3 = dayList[[pickerView selectedRowInComponent:2]];
            }
            _pickList3 = dayList;
            [pickerView reloadComponent:2];
        }
    }else if (component ==2){
        _pick3 = _pickList3[row];
    }else if (component ==3){
        _pick4 = _pickList4[row];
    }
}
@end
