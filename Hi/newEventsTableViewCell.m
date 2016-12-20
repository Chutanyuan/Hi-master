//
//  newEventsTableViewCell.m
//  Hi
//
//  Created by user_kevin on 16/11/17.
//  Copyright © 2016年 user_kevin. All rights reserved.
//

#import "newEventsTableViewCell.h"

@interface newEventsTableViewCell ()

@property(nonatomic,strong)UIImageView * headerImage;
@property(nonatomic,strong)UILabel * nickname;
@property(nonatomic,strong)UILabel * contentText;
@property(nonatomic,strong)UIImageView * photo1;
@property(nonatomic,strong)UIImageView * photo2;
@property(nonatomic,strong)UIImageView * photo3;
@property(nonatomic,strong)UIImageView * photo4;
@property(nonatomic,strong)UIImageView * photo5;
@property(nonatomic,strong)UIImageView * photo6;
@property(nonatomic,strong)UIImageView * photo7;
@property(nonatomic,strong)UIImageView * photo8;
@property(nonatomic,strong)UIImageView * photo9;

@property(nonatomic,strong)UILabel * timeWithNow;
@property(nonatomic,strong)UIButton * ZanOrPinglun;
@property(nonatomic,strong)UIView * grayview;
@property(nonatomic,strong)NSDictionary* dicData;

@end

@implementation newEventsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 45, 45)];
        _headerImage.layer.cornerRadius = 3;
        _headerImage.clipsToBounds = YES;
        [self addSubview:_headerImage];
        
        _nickname = [[UILabel alloc]init];
        [self addSubview:_nickname];
        
        _contentText = [[UILabel alloc]init];
        [self addSubview:_contentText];
        
        
        _photo1 = [[UIImageView alloc]init];
        [self addSubview:_photo1];
        _photo2 = [[UIImageView alloc]init];
        [self addSubview:_photo2];
        _photo3 = [[UIImageView alloc]init];
        [self addSubview:_photo3];
        _photo4 = [[UIImageView alloc]init];
        [self addSubview:_photo4];
        _photo5 = [[UIImageView alloc]init];
        [self addSubview:_photo5];
        _photo6 = [[UIImageView alloc]init];
        [self addSubview:_photo6];
        _photo7 = [[UIImageView alloc]init];
        [self addSubview:_photo7];
        _photo8 = [[UIImageView alloc]init];
        [self addSubview:_photo8];
        _photo9 = [[UIImageView alloc]init];
        [self addSubview:_photo9];
        
        _timeWithNow = [[UILabel alloc]init];
        [self addSubview:_timeWithNow];
        
        _ZanOrPinglun = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_ZanOrPinglun];
        
        
        _grayview = [[UIView alloc]init];
        [self addSubview:_grayview];

        
    }
    return self;
}

-(void)setDictionary:(NSDictionary *)dictionary
{
    NSLog(@"%@",dictionary);
    self.dicData = dictionary;
    _headerImage.image = [UIImage imageNamed:@"3"];

    _nickname.text = [NSString stringWithFormat:@"%@",dictionary[@"authorUsername"][@"nickName"]];
    _nickname.textColor = [CorlorTransform colorWithHexString:@"#5F5FA9"];
    _nickname.font = [FontOutSystem fontWithFangZhengSize:13.0];
    CGSize size_nickname = [_nickname.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_nickname.font,NSFontAttributeName, nil]];
    _nickname.frame = CGRectMake(_headerImage.frame.size.width+_headerImage.frame.origin.x+10, _headerImage.frame.origin.y, size_nickname.width, size_nickname.height);

    
    
    _contentText.text = [NSString stringWithFormat:@"%@",dictionary[@"content"]];
    _contentText.numberOfLines = 0;
    _contentText.font = [FontOutSystem fontWithFangZhengSize:13.0];
    CGSize size_contentText = [_contentText.text boundingRectWithSize:CGSizeMake(screenwidth-_nickname.frame.origin.x-_headerImage.frame.size.width+20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:_contentText.font,NSFontAttributeName, nil] context:nil].size;
    _contentText.frame = CGRectMake(_nickname.frame.origin.x, size_nickname.height+_nickname.frame.origin.y+10, size_contentText.width, size_contentText.height);
    
    
    CGRect frame = self.frame;
    if (_contentText.frame.origin.y+size_contentText.height>_headerImage.frame.origin.y+_headerImage.frame.size.height) {
        frame.size.height = _contentText.frame.origin.y+10+_contentText.frame.size.height;
    }else{
        frame.size.height = _headerImage.frame.origin.y*2+_headerImage.frame.size.height;
    }
    self.frame = frame;
    NSArray * photos = dictionary[@"photos"];
    
    if (photos.count==1) {
        
        _photo1.frame = CGRectMake(_contentText.frame.origin.x, _contentText.frame.origin.y+10+size_contentText.height, screenwidth-_nickname.frame.origin.x-_headerImage.frame.size.width+20, (screenwidth-_nickname.frame.origin.x-_headerImage.frame.size.width+20)/4*3);
        _photo1.contentMode = UIViewContentModeScaleAspectFill;
        _photo1.clipsToBounds = YES;
        [_photo1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",photos[0]]]];
        CGRect frame1 = self.frame;
        frame1.size.height = _photo1.frame.origin.y+_photo1.frame.size.height+10+30;
        self.frame = frame1;

    }else if (photos.count==2){
        _photo1.frame = CGRectMake(_contentText.frame.origin.x, _contentText.frame.origin.y+10+size_contentText.height, (screenwidth-_nickname.frame.origin.x-_headerImage.frame.size.width+10)/2, (screenwidth-_nickname.frame.origin.x-_headerImage.frame.size.width+10)/2);
        _photo1.contentMode = UIViewContentModeScaleAspectFill;
        _photo1.clipsToBounds = YES;
        [_photo1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",photos[0]]]];
        CGRect frame1 = self.frame;
        frame1.size.height = _photo1.frame.origin.y+_photo1.frame.size.height+10+30;
        self.frame = frame1;
        _photo2.frame = CGRectMake(_photo1.frame.origin.x+_photo1.frame.size.width+10, _photo1.frame.origin.y, _photo1.frame.size.width, _photo1.frame.size.height);
        _photo2.contentMode = UIViewContentModeScaleAspectFill;
        _photo2.clipsToBounds = YES;
        [_photo2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",photos[1]]]];
        
    }else if (photos.count==3){
        _photo1.frame = CGRectMake(_contentText.frame.origin.x, _contentText.frame.origin.y+10+size_contentText.height, (screenwidth-_nickname.frame.origin.x-_headerImage.frame.size.width)/3, (screenwidth-_nickname.frame.origin.x-_headerImage.frame.size.width)/3);
        _photo1.contentMode = UIViewContentModeScaleAspectFill;
        _photo1.clipsToBounds = YES;
        [_photo1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",photos[0]]]];
        CGRect frame1 = self.frame;
        frame1.size.height = _photo1.frame.origin.y+_photo1.frame.size.height+10+30;
        self.frame = frame1;
        _photo2.frame = CGRectMake(_photo1.frame.origin.x+_photo1.frame.size.width+10, _photo1.frame.origin.y, _photo1.frame.size.width, _photo1.frame.size.height);
        _photo2.contentMode = UIViewContentModeScaleAspectFill;
        _photo2.clipsToBounds = YES;
        [_photo2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",photos[1]]]];
        
        _photo3.frame = CGRectMake(_photo2.frame.origin.x+_photo2.frame.size.width+10, _photo2.frame.origin.y, _photo2.frame.size.width, _photo2.frame.size.height);
        _photo3.contentMode = UIViewContentModeScaleAspectFill;
        _photo3.clipsToBounds = YES;
        [_photo3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",photos[2]]]];
        

    }else if (photos.count==4){
        
    }else if (photos.count==5){
        
    }else if (photos.count==6){
        
    }else if (photos.count==7){
        
    }else if (photos.count==8){
        
    }else if (photos.count>=9){
        
    }else{
        
    }


    _timeWithNow.text = @"1分钟前";
    _timeWithNow.font = [FontOutSystem fontWithFangZhengSize:10.0];
    _timeWithNow.textColor = [CorlorTransform colorWithHexString:@"#BEBDBE"];
    CGSize size_timeWithNow = [_timeWithNow.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_timeWithNow.font,NSFontAttributeName, nil]];
    _timeWithNow.frame = CGRectMake(_nickname.frame.origin.x, _photo1.frame.origin.y+_photo1.frame.size.height+10, size_timeWithNow.width, size_timeWithNow.height);

    [_ZanOrPinglun setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    _ZanOrPinglun.center = CGPointMake(screenwidth-45, _timeWithNow.center.y);
    _ZanOrPinglun.bounds = CGRectMake(0, 0, 25, 25);
    [_ZanOrPinglun addTarget:self action:@selector(zanAndPinglun:) forControlEvents:UIControlEventTouchUpInside];

    
    _grayview.frame = CGRectMake(_ZanOrPinglun.frame.origin.x, _timeWithNow.frame.origin.y-5, 0, 30);
    _grayview.backgroundColor = [CorlorTransform colorWithHexString:@"#464C50"];
    _grayview.layer.cornerRadius = 5;
    _grayview.clipsToBounds = YES;

    
}

- (void)zanAndPinglun:(UIButton *)sender
{
    static int i = 0;
    i++;
    if (i%2==1) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _grayview.frame;
            _grayview.frame = CGRectMake(frame.origin.x-120, frame.origin.y , 120, 30);
        }completion:^(BOOL finished) {
            if (finished==YES) {
                
                NSLog(@"%@",_dicData);
                UIView * line = [[UIView alloc]initWithFrame:CGRectMake(_grayview.frame.size.width/2, 4, 1, _grayview.frame.size.height-8)];
                line.backgroundColor = [CorlorTransform colorWithHexString:@"#000000"];
                [_grayview addSubview:line];
                
                UIButton * zan = [UIButton buttonWithType:UIButtonTypeCustom];
                zan.frame = CGRectMake(0, 0, 60, 30);
                [zan setImage:[UIImage imageNamed:@"AlbumLike"] forState:UIControlStateNormal];
                [zan setTitle:@"赞" forState:UIControlStateNormal];
                zan.titleLabel.font = [FontOutSystem fontWithFangZhengSize:10.0];
                [zan addTarget:self action:@selector(zanAndPinglunTouch:) forControlEvents:UIControlEventTouchUpInside];
                [_grayview addSubview:zan];
                
                UIButton * pinglun = [UIButton buttonWithType:UIButtonTypeCustom];
                [pinglun setTitle:@"评论" forState:UIControlStateNormal];
                [pinglun setImage:[UIImage imageNamed:@"AlbumComment"] forState:UIControlStateNormal];
                pinglun.titleLabel.font = [FontOutSystem fontWithFangZhengSize:10.0];
                pinglun.frame = CGRectMake(60, 0, 60, 30);
                [pinglun addTarget:self action:@selector(zanAndPinglunTouch:) forControlEvents:UIControlEventTouchUpInside];
                [_grayview addSubview:pinglun];
                
            }else{
                NSLog(@"不知道什么梗");
            }
        }];

    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            _grayview.frame = CGRectMake(_ZanOrPinglun.frame.origin.x, _timeWithNow.frame.origin.y-5, 0, 30);
        }];
        
    }
}

- (void)zanAndPinglunTouch:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"赞"]) {
        [sender setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
        NSString * objectId = _dicData[@"objectId"];
        BmobUser * getUser = [BmobUser currentUser];
        NSString * userObjectID = [NSString stringWithFormat:@"%@",getUser.objectId];
        
        NSDictionary * sendDic = @{@"postId":objectId,@"userObjectId":userObjectID};
        [BmobCloud callFunctionInBackground:@"supportMoment" withParameters:sendDic block:^(NSString * dataArray, NSError *error) {
            if (error) {
                NSLog(@"error %@",[error description]);
            }else{
                
            }
            
        }] ;
    }
    if ([sender.titleLabel.text isEqualToString:@"评论"]) {
        
    }
    [UIView animateWithDuration:0.3 animations:^{
        _grayview.frame = CGRectMake(_ZanOrPinglun.frame.origin.x, _timeWithNow.frame.origin.y-5, 0, 30);
    }];

}
@end
