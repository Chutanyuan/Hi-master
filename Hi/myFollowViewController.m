//
//  myFollowViewController.m
//  Hi
//
//  Created by user_kevin on 16/11/16.
//  Copyright © 2016年 user_kevin. All rights reserved.
//

#import "myFollowViewController.h"
#import "UICollectionViewWaterfallLayout.h"
#import "longCollectionViewCell.h"

@interface myFollowViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateWaterfallLayout,longClooectionViewCellDelegate>
{
    UICollectionViewWaterfallLayout * _layout;
    UICollectionView * _collectionView;
}
@property (nonatomic,strong)UITableView * tableview;
@property (nonatomic,strong)NSArray * dataArray;


@end

@implementation myFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [[NSArray alloc]init];
    [self getdata];
}
/** Bmob 获取 _user 列表中的所有数据 */
-(void)getdata{
    BmobUser * bmobuser = [BmobUser currentUser];
    NSString * username = [bmobuser objectForKey:@"username"];
    NSDictionary * sendDic = @{@"identity":@"-1",@"depart":@"-1",@"sex":@"0",@"username":username,@"offset":@"0",@"limit":@"10"};
    [BmobCloud callFunctionInBackground:@"getMyFocusPeople" withParameters:sendDic block:^(NSString * dataArray, NSError *error) {
        if (error) {
            NSLog(@"error %@",[error description]);
        }
        self.dataArray = [String_Array dictionaryWithJsonString:dataArray];
        
        if (self.dataArray.count>0) {
            [self tableview];
        }else{
            UILabel * label = [[UILabel alloc]initWithFrame:self.view.frame];
            label.text = @"尚未关注他人";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [FontOutSystem fontWithFangZhengZhenSize:15.0];
            label.textColor = [CorlorTransform colorWithHexString:@"#686868"];
            [self.view addSubview:label];
        }
        
    }] ;
    
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenwidth, screenheight) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor whiteColor];
        _layout = [[UICollectionViewWaterfallLayout alloc]init];
        _layout.columnCount = 2;//设置两列
        _layout.itemWidth = (screenwidth-30)/2;//设置每个item的宽
        _layout.delegate = self;//通过代理设置item的高
        _layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//设置区和四周边界的距离
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:_layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [CorlorTransform colorWithHexString:@"#D9D8D9"];
        _collectionView.scrollEnabled = NO;//禁止collection的滑动
        [_collectionView registerClass:[longCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [cell.contentView addSubview:_collectionView];
        
        [_collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _collectionView.contentSize.height + 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwidth, 44)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark----collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (_dataArray.count>0) {
        return _dataArray.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    longCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.username_bmob = _dataArray[indexPath.item];
    cell.delegate = self;
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"第%ld个",(long)indexPath.item);
}
#pragma mark - UICollectionViewDelegateWaterfallLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewWaterfallLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return (_layout.itemWidth/5*6)*2+20+10;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGSize size = [change[@"new"] CGSizeValue];
    //修改 CollectionView 的高度为显示区域的高度。
    CGRect frame = _collectionView.frame;
    frame.size.height = size.height;
    _collectionView.frame = frame;
    [_tableview reloadData];
}
- (void)dealloc
{
    [_collectionView removeObserver:self forKeyPath:@"contentSize"];
}

-(void)removeFocusSuccess:(UIButton *)sender
{
    BmobUser * bmobuser = [BmobUser currentUser];
    NSString * username = [bmobuser objectForKey:@"username"];
    NSDictionary * sendDic = @{@"identity":@"-1",@"depart":@"-1",@"sex":@"0",@"username":username,@"offset":@"0",@"limit":@"10"};
    [BmobCloud callFunctionInBackground:@"getMyFocusPeople" withParameters:sendDic block:^(NSString * dataArray, NSError *error) {
        if (error) {
            NSLog(@"error %@",[error description]);
        }
        self.dataArray = [String_Array dictionaryWithJsonString:dataArray];
        
        if (self.dataArray.count>0) {
            [_collectionView reloadData];
        }else{
            UILabel * label = [[UILabel alloc]initWithFrame:self.view.frame];
            label.text = @"小窝里已经没有人了哟";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [FontOutSystem fontWithFangZhengZhenSize:15.0];
            label.textColor = [CorlorTransform colorWithHexString:@"#686868"];
            [self.view addSubview:label];
            [_collectionView reloadData];
        }
        
    }] ;
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
