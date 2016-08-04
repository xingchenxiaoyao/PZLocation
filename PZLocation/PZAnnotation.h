//
//  PZAnnotation.h
//  PZLocation
//
//  Created by 赵朋 on 16/8/2.
//  Copyright © 2016年 赵朋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PZAnnotation : NSObject

@property (nonatomic) CLLocationCoordinate2D  coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) UIImage *image;

@end
