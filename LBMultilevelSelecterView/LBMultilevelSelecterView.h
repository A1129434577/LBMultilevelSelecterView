//
//  LBMultilevelSelecterView.h
//  TestDome
//
//  Created by 刘彬 on 2020/3/27.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LBMultilevelSelecterViewDelegate <NSObject>
@optional
/// 行高
/// @param tableView 当前tableView
/// @param indexPath 当前tableView的indexPath
/// @param column 当前列
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath forColumn:(NSUInteger )column;

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section forColumn:(NSUInteger )column;

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section forColumn:(NSUInteger )column;

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section forColumn:(NSUInteger )column;

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section forColumn:(NSUInteger )column;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath forColumn:(NSUInteger )column;

@end

@protocol LBMultilevelSelecterViewDataSource <NSObject>
@optional
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView forColumn:(NSUInteger )column;

@required
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section forColumn:(NSUInteger )column;

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath forColumn:(NSUInteger )column;

@end


@interface LBMultilevelSelecterView : UIView
@property (nonatomic, strong, readonly) NSArray<UITableView *> *allTableView;


- (instancetype)initWithLevelWidths:(NSArray<NSNumber *> *)levelWidths style:(UITableViewStyle)style;

@property (nonatomic, weak, nullable) id <LBMultilevelSelecterViewDataSource> lb_dataSource;
@property (nonatomic, weak, nullable) id <LBMultilevelSelecterViewDelegate> lb_delegate;

-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
