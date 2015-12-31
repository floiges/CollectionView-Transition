//
//  Photos.h
//  CollectionViewTest
//
//  Created by 224 on 15/12/29.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (copy, nonatomic) NSString *caption;
@property (copy, nonatomic) NSString *comment;
@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithCaption:(NSString *)caption
                     andComment:(NSString *)comment
                       andImage:(UIImage *)image;

- (instancetype)initPhotoWithDictionary:(NSDictionary *)dictionary;

- (CGFloat)heightForCommentWithFont:(UIFont *)font andWidth:(CGFloat)width;

+ (NSArray *)allPhotos;

@end
