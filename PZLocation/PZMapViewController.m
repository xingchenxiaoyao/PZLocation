//
//  PZMapViewController.m
//  PZLocation
//
//  Created by 赵朋 on 16/8/2.
//  Copyright © 2016年 赵朋. All rights reserved.
//

#import "PZMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "PZAnnotation.h"

@interface PZMapViewController ()<MKMapViewDelegate>{
    
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
    CLGeocoder *_geocoder;
    PZAnnotation *annotation1;

}


@end

@implementation PZMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
    // Do any additional setup after loading the view.
}


- (void) buildUI{
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    _mapView = [[MKMapView alloc] initWithFrame:rect];
    
    [self.view addSubview:_mapView];
    
    _mapView.delegate = self;
    
    _locationManager = [[CLLocationManager alloc] init];
    
    if (![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [_locationManager requestWhenInUseAuthorization];
        
        
    }
    
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    _mapView.mapType = MKMapTypeStandard;
    

    
    
    
}

- (void) addAnnotationWithUserLocation:(MKUserLocation *)userLocation{
    
    
    CLLocation *location = userLocation.location;
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    

    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    
    annotation1 = [[PZAnnotation alloc] init];
    
    annotation1.title = userLocation.title;
    
    annotation1.subtitle = userLocation.subtitle;
    
    annotation1.image = [UIImage imageNamed:@"pay_way_selected"];
    
    annotation1.coordinate = location1;
    
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [_mapView addAnnotation:annotation1];
    
}

- (void) getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        
        annotation1.title = [placemark.addressDictionary objectForKey:@"City"];
        
    }];
    
    
    
}




- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"%@",userLocation);

    [self addAnnotationWithUserLocation:userLocation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
