//
//  Photos.m
//  CollectionViewTest
//
//  Created by 224 on 15/12/29.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import "Photo.h"
#import "UIImage+Decompression.h"

@implementation Photo

- (instancetype)initWithCaption:(NSString *)caption
                     andComment:(NSString *)comment
                       andImage:(UIImage *)image {
    if (self = [super init]) {
        _caption = [caption copy];
        _comment = [comment copy];
        _image = image;
    }
    
    return self;
}

- (instancetype)initPhotoWithDictionary:(NSDictionary *)dictionary {
    NSString *caption = (NSString *)dictionary[@"Caption"];
    NSString *comment = (NSString *)dictionary[@"Comment"];
    NSString *photoName = (NSString *)dictionary[@"Photo"];
    UIImage *image = [UIImage imageNamed:photoName];
    return [self initWithCaption:caption andComment:comment
                        andImage:[UIImage decompressedImage:image]];
}

- (CGFloat)heightForCommentWithFont:(UIFont *)font andWidth:(CGFloat)width {
    CGSize size = [self.comment boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName: font}
                                             context:nil].size;
    return ceil(size.height);
}

+ (NSArray *)allPhotos {
    NSMutableArray *photos = [NSMutableArray new];
    
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"Photos" withExtension:@"plist"];
    NSArray *photosFromPlist = [[NSArray alloc] initWithContentsOfURL:URL];
    for (NSDictionary *dictionary in photosFromPlist) {
        Photo *photo = [[Photo alloc] initPhotoWithDictionary:dictionary];
        [photos addObject:photo];
    }
    
    return [photos copy];
}

@end
