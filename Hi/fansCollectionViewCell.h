//
//  fansCollectionViewCell.h
//  Hi
//
//  Created by user_kevin on 16/12/6.
//  Copyright © 2016年 user_kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol fanCollectionViewCellDelegate <NSObject>

-(void)hateSomeBodySuccess:(UIButton *)sender;

@end

@interface fansCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)NSDictionary * username_bmob;
@property(nonatomic,weak)id<fanCollectionViewCellDelegate>delegate;

@end
