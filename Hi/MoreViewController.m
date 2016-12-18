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
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSLog(@"%@",_dataObject);
    [self tableview];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenwidth, screenheight-64) style:UITableViewStyleGrouped];
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
    cell.backgroundColor = [CorlorTransform colorWithHexString:@"#55565A"];
    NSDictionary * user = [_dataObject objectForKey:@"user"];
    NSArray * photos = user[@"backgroundPhotos"];
    cell.photos = photos[indexPath.row];
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwidth, self.view.frame.size.height-64)];
    headView.backgroundColor = [CorlorTransform colorWithHexString:@"#55565A"];
    NSDictionary * user = [_dataObject objectForKey:@"user"];
    UIImageView * headPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, screenwidth-20, headView.frame.size.height-160)];
    headPhoto.backgroundColor = [UIColor redColor];
    [headPhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",user[@"headPhoto"]]]];
    headPhoto.contentMode = UIViewContentModeScaleAspectFill;
    headPhoto.clipsToBounds = YES;
    [headView addSubview:headPhoto];
    
    UILabel * shenfen = [[UILabel alloc]initWithFrame:CGRectMake(10, headPhoto.frame.origin.y+headPhoto.frame.size.height+10, (headPhoto.frame.size.width-10)/2, 40)];
    if (!user[@"userIdentity"]) {
        shenfen.text = @"身份";
    }else{
        shenfen.text = [NSString stringWithFormat:@"%@",user[@"userIdentity"]];
    }
    shenfen.text = [NSString stringWithFormat:@"%@",user[@"userIdentity"]];
    shenfen.textAlignment = NSTextAlignmentCenter;
    shenfen.layer.cornerRadius = 5;
    shenfen.clipsToBounds = YES;
    shenfen.backgroundColor = [UIColor whiteColor];
    [headView addSubview:shenfen];
    
    UILabel * chengshi = [[UILabel alloc]initWithFrame:CGRectMake(shenfen.frame.origin.x + shenfen.frame.size.width+10, shenfen.frame.origin.y, shenfen.frame.size.width, shenfen.frame.size.height)];
    
    if (!user[@"city"]) {
        chengshi.text = @"城市";
    }else{
        chengshi.text = [NSString stringWithFormat:@"%@",user[@"city"]];
    }
    chengshi.textAlignment = NSTextAlignmentCenter;
    chengshi.layer.cornerRadius = 5;
    chengshi.clipsToBounds = YES;
    chengshi.backgroundColor = [UIColor whiteColor];
    [headView addSubview:chengshi];
    
    UILabel * hobby = [[UILabel alloc]initWithFrame:CGRectMake(10, shenfen.frame.origin.y+shenfen.frame.size.height+10, (headPhoto.frame.size.width-10)/2, 40)];
    if (!user[@"hobby"]) {
        hobby.text = @"爱好";
    }else{
        hobby.text = [NSString stringWithFormat:@"%@",user[@"hobby"]];
    }
    hobby.textAlignment = NSTextAlignmentCenter;
    
    hobby.layer.cornerRadius = 5;
    hobby.clipsToBounds = YES;
    hobby.backgroundColor = [UIColor whiteColor];
    [headView addSubview:hobby];
    
    UILabel * movie = [[UILabel alloc]initWithFrame:CGRectMake(hobby.frame.origin.x + hobby.frame.size.width+10, hobby.frame.origin.y, hobby.frame.size.width, hobby.frame.size.height)];
    if (!user[@"movie"]) {
        movie.text = @"电影";
    }else{
        movie.text = [NSString stringWithFormat:@"%@",user[@"movie"]];
    }
    movie.textAlignment = NSTextAlignmentCenter;
    movie.layer.cornerRadius = 5;
    movie.clipsToBounds = YES;
    movie.backgroundColor = [UIColor whiteColor];
    [headView addSubview:movie];
    
    UILabel * food = [[UILabel alloc]initWithFrame:CGRectMake(10, hobby.frame.origin.y+hobby.frame.size.height+10, hobby.frame.size.width, 40)];
    if (!user[@"food"]) {
        food.text = @"食物";
    }else{
        food.text = [NSString stringWithFormat:@"%@",user[@"food"]];
    }
    food.layer.cornerRadius = 5;
    food.clipsToBounds = YES;
    food.backgroundColor = [UIColor whiteColor];

    food.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:food];
    
    UILabel * lovePlace = [[UILabel alloc]initWithFrame:CGRectMake(movie.frame.origin.x, movie.frame.origin.y+movie.frame.size.height+10, movie.frame.size.width, movie.frame.size.height)];
    if (!user[@"lovePlace"]) {
        lovePlace.text = @"旅游地点";
    }else{
        lovePlace.text = [NSString stringWithFormat:@"%@",user[@"lovePlace"]];
    }
    lovePlace.layer.cornerRadius = 5;
    lovePlace.clipsToBounds = YES;
    lovePlace.backgroundColor = [UIColor whiteColor];

    lovePlace.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:lovePlace];
    
    return headView;
}


@end
