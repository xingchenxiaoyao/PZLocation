//
//  PZViewController.m
//  PZLocation
//
//  Created by 赵朋 on 16/8/5.
//  Copyright © 2016年 赵朋. All rights reserved.
//

#import "PZViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface PZViewController ()

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation PZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _geocoder=[[CLGeocoder alloc]init];
//    [self location];

//    [self listPlacemark];
    
    [self turnByTurn];
    
    // Do any additional setup after loading the view.
}
//标记单位置
- (void)location{
    
    [_geocoder geocodeAddressString:@"北京" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        CLPlacemark *placemark1 = [placemarks firstObject];
        
        MKPlacemark *mkPlacemark1 = [[MKPlacemark alloc] initWithPlacemark:placemark1];
        
        NSDictionary *option = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard)};
        
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:mkPlacemark1];
        
        [mapItem openInMapsWithLaunchOptions:option];
    }];


}
//标记多位置
- (void)listPlacemark{

    [_geocoder geocodeAddressString:@"北京市" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
    
        CLPlacemark *plackmark1 = [placemarks firstObject];
        
        MKPlacemark *mkPlacemark1 = [[MKPlacemark alloc] initWithPlacemark:plackmark1];
        
        [_geocoder geocodeAddressString:@"杭州市" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
           
            CLPlacemark *plackmark2 = [placemarks firstObject];
            
            MKPlacemark *mkPlacemark2 = [[MKPlacemark alloc] initWithPlacemark:plackmark2];
            
            NSDictionary *options = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard)};
            
            MKMapItem *mapItem1 = [[MKMapItem alloc] initWithPlacemark:mkPlacemark1];
            MKMapItem *mapItem2 = [[MKMapItem alloc] initWithPlacemark:mkPlacemark2];
            
            [MKMapItem openMapsWithItems:@[mapItem1,mapItem2] launchOptions:options];
            
        }];
    }];

}

//导航
- (void)turnByTurn{

    [_geocoder geocodeAddressString:@"北京市" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        CLPlacemark *placedmark1 = [placemarks firstObject];
        MKPlacemark *mkPlacemark1 = [[MKPlacemark alloc] initWithPlacemark:placedmark1];
        
        [_geocoder geocodeAddressString:@"杭州市" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
           
            CLPlacemark *placemark2 = [placemarks firstObject];
            MKPlacemark *mkplacemark2 = [[MKPlacemark alloc] initWithPlacemark:placemark2];
            
            NSDictionary *options = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving};
            
            MKMapItem *mapItem1 = [[MKMapItem alloc] initWithPlacemark:mkPlacemark1];
            MKMapItem *mapItem2 = [[MKMapItem alloc] initWithPlacemark:mkplacemark2];
            
            [MKMapItem openMapsWithItems:@[mapItem1,mapItem2] launchOptions:options];
        }];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
