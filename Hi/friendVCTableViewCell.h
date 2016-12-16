//
//  friendVCTableViewCell.h
//  Hi
//
//  Created by user_kevin on 16/12/9.
//  Copyright © 2016年 user_kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
@interface friendVCTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * nickname;

@property(nonatomic,assign)Person * user;

@end
