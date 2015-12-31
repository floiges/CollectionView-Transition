//
//  PinterestLayoutAttributes.m
//  CollectionViewTest
//
//  Created by 224 on 15/12/30.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import "PinterestLayoutAttributes.h"

@implementation PinterestLayoutAttributes

//Subclasses of UICollectionViewLayoutAttributes need to conform to the NSCopying protocol
//because the attribute’s objects can be copied internally.
- (id)copyWithZone:(NSZone *)zone {
    PinterestLayoutAttributes *copy = [super copyWithZone:zone];
    copy.photoHeight = self.photoHeight;
    return copy;
}

//This overrides isEqual(_:), and it’s mandatory as well.
//The collection view determines whether the attributes have changed by comparing the old and new attribute objects
//using isEqual(_:).
//You must implement it to compare the custom properties of your subclass.
- (BOOL)isEqual:(id)object {
    PinterestLayoutAttributes *attributes = object;
    if (attributes.photoHeight == self.photoHeight) {
        return [super isEqual:object];
    }
    
    return false;
}

@end
