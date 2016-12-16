//
//  MoreViewCell.m
//  Hi
//
//  Created by user_kevin on 16/12/16.
//  Copyright © 2016年 user_kevin. All rights reserved.
//

#import "MoreViewCell.h"

@interface MoreViewCell ()

@property(nonatomic,strong)UIImageView * imageview;

@end

@implementation MoreViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imageview = [[UIImageView alloc]init];
        _imageview.frame = CGRectMake(10, 10, screenwidth-20, screenheight-204);
        _imageview.contentMode = UIViewContentModeScaleAspectFill;
        _imageview.clipsToBounds = YES;
        [self addSubview:_imageview];
        CGRect frame = self.frame;
        frame.size.height = _imageview.frame.size.height+20;
        self.frame = frame;
    }
    return self;
}
-(void)setPhotos:(NSString *)photos
{
    [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",photos]]];
}

@end
