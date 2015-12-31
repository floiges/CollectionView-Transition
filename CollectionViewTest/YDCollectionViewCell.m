//
//  YDCollectionViewCell.m
//  CollectionViewTest
//
//  Created by 224 on 15/12/29.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import "YDCollectionViewCell.h"
#import "UIColor+RandomColor.h"
#import "PinterestLayoutAttributes.h"

@implementation YDCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
//    self.backgroundColor = [UIColor randomColor];
}

- (void)setPhoto:(Photo *)photo {
    _imageView.image = photo.image;
    _CaptionLabel.text = photo.caption;
    _CommentLabel.text = photo.comment;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    PinterestLayoutAttributes *attributes = (PinterestLayoutAttributes *)layoutAttributes;
    self.imageViewHeightConstraint.constant = attributes.photoHeight;
}

@end
