//
//  YDCollectionViewCell.h
//  CollectionViewTest
//
//  Created by 224 on 15/12/29.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface YDCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *CaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *CommentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;

@property (strong, nonatomic) Photo *photo;
@end
