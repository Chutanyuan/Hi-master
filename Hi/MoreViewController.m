//
//  MoreViewController.m
//  Hi
//
//  Created by user_kevin on 16/12/16.
//  Copyright © 2016年 user_kevin. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreViewCell.h"
@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableview;
@end

@implementation MoreViewController
@synthesize dataObject=_dataObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    NSLog(@"%@",_dataObject);
    [self tableview];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.dataSource = self;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MoreViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary * user = [_dataObject objectForKey:@"user"];
    cell.photos = user[@"backgroundPhotos"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.frame.size.height;
}


@end
