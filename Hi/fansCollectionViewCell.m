//
//  fansCollectionViewCell.m
//  Hi
//
//  Created by user_kevin on 16/12/6.
//  Copyright © 2016年 user_kevin. All rights reserved.
//

#import "fansCollectionViewCell.h"

@interface fansCollectionViewCell ()<UITextViewDelegate,MBProgressHUDDelegate>
{
    NSString * otherusername;
}


@property(nonatomic,strong)UIImageView * showImageView;
@property(nonatomic,strong)UILabel * fansCount;
@property(nonatomic,strong)UIButton * addFriend;
@property(nonatomic,strong)UIView * centerLine;

@property(nonatomic,strong)UILabel * identity;
@property(nonatomic,strong)UILabel * address;
@property(nonatomic,strong)UILabel * heightOfPerson;
@property(nonatomic,strong)UIButton * delegateFriends;

@property(nonatomic,strong)UITextView * textview;
@property(nonatomic,strong)UILabel * placeholdText;
@property(nonatomic,strong)UIImageView * backgroundImage;



@end

@implementation fansCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _showImageView = [[UIImageView alloc]init];
        [self addSubview:_showImageView];
        
        _fansCount = [[UILabel alloc]init];
        _fansCount.font = [FontOutSystem fontWithFangZhengZhenSize:14.0];
        [self addSubview:_fansCount];
        
        _addFriend = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_addFriend];
        
        _centerLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2, self.frame.size.width, 1)];
        _centerLine.backgroundColor = [CorlorTransform colorWithHexString:@"#BABABA"];
        [self addSubview:_centerLine];
        
        
        _identity = [[UILabel alloc]init];
        _identity.font = [FontOutSystem fontWithFangZhengZhenSize:16.0];
        _identity.textAlignment = NSTextAlignmentCenter;
        _identity.layer.cornerRadius = 5;
        _identity.layer.borderColor = [CorlorTransform colorWithHexString:@"BBBBBB"].CGColor;
        _identity.layer.borderWidth = 1;
        _identity.clipsToBounds = YES;
        [self addSubview:_identity];
        
        _address = [[UILabel alloc]init];
        _address.font = [FontOutSystem fontWithFangZhengZhenSize:16.0];
        _address.textAlignment = NSTextAlignmentCenter;
        _address.layer.cornerRadius = 5;
        _address.layer.borderColor = [CorlorTransform colorWithHexString:@"BBBBBB"].CGColor;
        _address.layer.borderWidth = 1;
        _address.clipsToBounds = YES;
        [self addSubview:_address];
        
        _heightOfPerson = [[UILabel alloc]init];
        _heightOfPerson.font = [FontOutSystem fontWithFangZhengZhenSize:16.0];
        _heightOfPerson.textAlignment = NSTextAlignmentCenter;
        _heightOfPerson.layer.cornerRadius = 5;
        _heightOfPerson.layer.borderColor = [CorlorTransform colorWithHexString:@"BBBBBB"].CGColor;
        _heightOfPerson.layer.borderWidth = 1;
        _heightOfPerson.clipsToBounds = YES;
        [self addSubview:_heightOfPerson];
        
        _delegateFriends = [UIButton buttonWithType:UIButtonTypeCustom];
        _delegateFriends.layer.cornerRadius = 5;
        _delegateFriends.layer.borderColor = [CorlorTransform colorWithHexString:@"BBBBBB"].CGColor;
        _delegateFriends.layer.borderWidth = 1;
        _delegateFriends.clipsToBounds = YES;
        [self addSubview:_delegateFriends];
        
        
        _backgroundImage = [[UIImageView alloc]init];
        [self addSubview:_backgroundImage];
        
        
        _textview = [[UITextView alloc]init];
        _textview.delegate = self;
        _textview.font = [FontOutSystem fontWithFangZhengSize:16.0];
        [self addSubview:_textview];
        
        _placeholdText = [[UILabel alloc]init];
        _placeholdText.font = [FontOutSystem fontWithFangZhengSize:16.0];
        
        _placeholdText.numberOfLines = 0;
        [self addSubview:_placeholdText];
        
        
    }
    return self;
}

-(void)setUsername_bmob:(NSDictionary *)username_bmob
{
    model_dic * dic = [[model_dic alloc]initWithDictionary:username_bmob];
    [_showImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic.headPhoto]]];
    _showImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    
    if ([dic.isFocus isEqualToString:@"0"]) {
        _addFriend.center = CGPointMake(self.frame.size.width-10-15, self.frame.size.width+(self.frame.size.height/2-self.frame.size.width)/2);
        _addFriend.bounds = CGRectMake(0, 0, 30, 30);
        [_addFriend setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        
    }else{
        [_addFriend setTitle:@"已关注" forState:UIControlStateNormal];
        _addFriend.titleLabel.font = [FontOutSystem fontWithFangZhengZhenSize:10.0];
        CGSize addfriendSize = [_addFriend.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_addFriend.titleLabel.font,NSFontAttributeName, nil]];
        [_addFriend setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _addFriend.center = CGPointMake(self.frame.size.width-10-addfriendSize.width/2,self.frame.size.width+(self.frame.size.height/2-self.frame.size.width)/2);
        _addFriend.bounds = CGRectMake(0, 0, addfriendSize.width, 30);
        
    }

    
    otherusername = dic.username;
    
    [_addFriend addTarget:self action:@selector(addFriendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _fansCount.frame = CGRectMake(10, self.frame.size.width, self.frame.size.width, self.frame.size.height/2-self.frame.size.width);
    _fansCount.text = [NSString stringWithFormat:@"粉丝：%@人",dic.fansNumber];
    CGSize size_fans = [_fansCount.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fansCount.font,NSFontAttributeName, nil]];
    
    if (size_fans.width>_addFriend.frame.origin.x-15) {
        size_fans.width = _addFriend.frame.origin.x-15;
    }
    
    _fansCount.frame = CGRectMake(10, self.frame.size.width+((self.frame.size.height/2-self.frame.size.width)/2)-size_fans.height/2, size_fans.width, size_fans.height);
    
    _identity.text = [NSString stringWithFormat:@"%@",dic.userIdentity];
    
    if ([_identity.text isEqual:@""]) {
        _identity.text = @"身份未设置";
    }
    
    CGSize size_Identity = [_identity.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_identity.font,NSFontAttributeName, nil]];
    _identity.frame = CGRectMake(10, _centerLine.frame.origin.y+11, self.frame.size.width-20, size_Identity.height+10);
    
    _address.text = [NSString stringWithFormat:@"%@",dic.city];
    if ([_address.text isEqualToString:@""]) {
        _address.text = @"区域未知";
    }
    
    _address.frame = CGRectMake(_identity.frame.origin.x, _identity.frame.origin.y+_identity.frame.size.height+10, _identity.frame.size.width, _identity.frame.size.height);
    
    _heightOfPerson.text = [NSString stringWithFormat:@"%@",dic.height];
    if ([_heightOfPerson.text isEqualToString:@""]||[_heightOfPerson.text isEqualToString:@"0"]) {
        _heightOfPerson.text = @"身高未知";
    }
    _heightOfPerson.frame = CGRectMake(_address.frame.origin.x, _address.frame.size.height+_address.frame.origin.y+10, _address.frame.size.width, _address.frame.size.height);
    
    
    _textview.frame = CGRectMake(_heightOfPerson.frame.origin.x+5, _heightOfPerson.frame.origin.y+_heightOfPerson.frame.size.height, _heightOfPerson.frame.size.width-10, self.frame.size.height-(_heightOfPerson.frame.origin.y+_heightOfPerson.frame.size.height)-50);
    
    _placeholdText.text = @"输入申请加为好友的文字字数控制在36字内。使用“约吗？”等话语易被拉黑。";
    _placeholdText.textColor = [CorlorTransform colorWithHexString:@"#BABABA"];
    CGSize size = CGSizeMake(_heightOfPerson.frame.size.width-15, 1000);
    CGSize size_placehold = [_placeholdText.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:_placeholdText.font,NSFontAttributeName, nil] context:nil].size;
    _placeholdText.frame = CGRectMake(_textview.frame.origin.x+5, _textview.frame.origin.y+7, size_placehold.width, _textview.frame.size.height);
    
    _delegateFriends.frame = CGRectMake(_heightOfPerson.frame.origin.x, _textview.frame.origin.y+_textview.frame.size.height+10, _heightOfPerson.frame.size.width, _heightOfPerson.frame.size.height);
    [_delegateFriends setTitle:@"打入冷宫" forState:UIControlStateNormal];
    [_delegateFriends setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _delegateFriends.titleLabel.font = [FontOutSystem fontWithFangZhengZhenSize:16.0];
    [_delegateFriends addTarget:self action:@selector(delegateFans:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        _placeholdText.text = @"";
    }else{
        _placeholdText.text = @"输入申请加为好友的文字字数控制在36字内。使用“约吗？”等话语易被拉黑。";
    }
}
- (void)addFriendAction:(UIButton *)sender
{
    /**
     添加关注
     */
    MBProgressHUD* HUD = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"添加关注";
    NSString * myusername = [[BmobUser currentUser] objectForKey:@"username"];
    NSDictionary * sendDic = @{@"from":myusername,@"to":otherusername};
    [BmobCloud callFunctionInBackground:@"addFocus" withParameters:sendDic block:^(id object, NSError *error) {
        if (error) {
            NSLog(@"error %@",[error description]);
        }else{
            [HUD hide:YES afterDelay:0.5];
        }
    }] ;
    
    
}
- (void)delegateFans:(UIButton *)sender
{
    MBProgressHUD* HUD = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"打入冷宫";
    NSString * myusername = [[BmobUser currentUser] objectForKey:@"username"];
    NSDictionary * sendDic = @{@"from":myusername,@"to":otherusername};
    [BmobCloud callFunctionInBackground:@"hateSomeBody" withParameters:sendDic block:^(id object, NSError *error) {
        if (error) {
            NSLog(@"error %@",[error description]);
        }else{
            [HUD hide:YES afterDelay:0.5];
            [self.delegate hateSomeBodySuccess:sender];
        }
    }] ;
}

@end
