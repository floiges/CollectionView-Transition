//
//  UIImage+Decompression.m
//  CollectionViewTest
//
//  Created by 224 on 15/12/29.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import "UIImage+Decompression.h"

@implementation UIImage (Decompression)

+ (UIImage *)decompressedImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(image.size, true, 0);
    [image drawAtPoint:CGPointZero];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

@end
