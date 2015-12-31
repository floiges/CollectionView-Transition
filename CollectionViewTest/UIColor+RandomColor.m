//
//  UIColor+RandomColor.m
//  CollectionViewTest
//
//  Created by 224 on 15/12/29.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+ (UIColor *)randomColor {
    CGFloat hue = arc4random() % 256 / 256.0;//色调随机：0.0~1.0
    //饱和度随机0.5~1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    //亮度随机0.5~1.0
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

@end
