//
//  LBMultilevelSelecterView.m
//  TestDome
//
//  Created by 刘彬 on 2020/3/27.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBMultilevelSelecterView.h"

@interface LBMultilevelSelecterView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray<UITableView *> *tableViewArray;

@end
@implementation LBMultilevelSelecterView

- (instancetype)initWithLevelWidths:(NSArray<NSNumber *> *)levelWidths style:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        __block CGFloat currentWidth = 0;
        [levelWidths enumerateObjectsUsingBlock:^(NSNumber * _Nonnull width, NSUInteger idx, BOOL * _Nonnull stop) {
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(currentWidth, 0, width.floatValue, 0) style:style];
            tableView.tableFooterView = [UIView new];
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            tableView.delegate = self;
            tableView.dataSource = self;
            [self addSubview:tableView];
            [self.tableViewArray addObject:tableView];
            currentWidth += width.floatValue;
        }];
        
    }
    return self;
}

-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self reloadData];
}

-(void)reloadData{    
    __weak typeof(self) weakSelf = self;
    [self.tableViewArray enumerateObjectsUsingBlock:^(UITableView * _Nonnull tableView, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect tableViewFrame = tableView.frame;
        tableViewFrame.size.height = CGRectGetHeight(weakSelf.frame);
        tableView.frame = tableViewFrame;
        [tableView reloadData];
    }];
    
}

-(void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    [self.tableViewArray enumerateObjectsUsingBlock:^(UITableView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tintColor = tintColor;
    }];
}

#pragma mark getter
- (NSMutableArray<UITableView *> *)tableViewArray{
    if (!_tableViewArray) {
        _tableViewArray = [NSMutableArray array];
    }
    return _tableViewArray;
}

-(NSArray<UITableView *> *)allTableView{
    return _tableViewArray.copy;
}




#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.lb_dataSource respondsToSelector:@selector(numberOfSectionsInTableView:forColumn:)]) {
        return [self.lb_dataSource numberOfSectionsInTableView:tableView forColumn:[self.tableViewArray indexOfObject:tableView]];
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.lb_dataSource tableView:tableView numberOfRowsInSection:section forColumn:[self.tableViewArray indexOfObject:tableView]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.lb_dataSource tableView:tableView cellForRowAtIndexPath:indexPath forColumn:[self.tableViewArray indexOfObject:tableView]];
}
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.lb_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:forColumn:)]) {
        return [self.lb_delegate tableView:tableView heightForRowAtIndexPath:indexPath forColumn:[self.tableViewArray indexOfObject:tableView]];
    }
    return 44;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.lb_delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:forColumn:)]) {
        return [self.lb_delegate tableView:tableView heightForHeaderInSection:section forColumn:[self.tableViewArray indexOfObject:tableView]];
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self.lb_delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.lb_delegate tableView:tableView heightForFooterInSection:section forColumn:[self.tableViewArray indexOfObject:tableView]];
    }
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self.lb_delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.lb_delegate tableView:tableView viewForHeaderInSection:section forColumn:[self.tableViewArray indexOfObject:tableView]];
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self.lb_delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:forColumn:)]) {
        return [self.lb_delegate tableView:tableView viewForFooterInSection:section forColumn:[self.tableViewArray indexOfObject:tableView]];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger index = [self.tableViewArray indexOfObject:tableView];
    if ([self.lb_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:forColumn:)]) {
        [self.lb_delegate tableView:tableView didSelectRowAtIndexPath:indexPath forColumn:index];
    }
    
    for (NSUInteger i = index+1; i < self.tableViewArray.count; i ++) {
        UITableView *nextTabelView = self.tableViewArray[i];
        [nextTabelView reloadData];
    }
}


@end
