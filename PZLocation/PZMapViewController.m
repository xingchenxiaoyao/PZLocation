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
    
    

}

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation PZMapViewController

- (CLGeocoder *)geocoder{

    if (!_geocoder) {
        _geocoder = [CLGeocoder new];
    }
    
    return _geocoder;
}

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
    
    
//    CLLocation *location = userLocation.location;
    
//    CLLocationCoordinate2D coordinate = location.coordinate;
    
    

    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(39.87, 116.45);
    
//    [_mapView removeOverlays:_mapView.overlays];
//    [_mapView removeAnnotations:_mapView.annotations];
    
    
    PZAnnotation *annotation1 = [[PZAnnotation alloc] init];
    
    annotation1.title = @"北京";
    
    annotation1.subtitle = @"北京欢迎你";
    
    annotation1.image = [UIImage imageNamed:@"datou"];

    
    annotation1.coordinate = location1;
    
    
    [_mapView addAnnotation:(id)annotation1];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[PZAnnotation class]]) {
        
        static NSString *key1 = @"AnnotationKey1";
        
        MKAnnotationView *annotatrionView = [_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        
        if (!annotatrionView) {
            annotatrionView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:key1];
            annotatrionView.canShowCallout = YES;
            annotatrionView.calloutOffset = CGPointMake(0, 1);
            annotatrionView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"datou"]];
        }
        
        annotatrionView.annotation = annotation;
        
        annotatrionView.image = ((PZAnnotation *)annotation).image;
        
        return annotatrionView;
        
    } else {
        
        return nil;
    
    }

}




- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"%@",userLocation);

    [self addAnnotationWithUserLocation:userLocation];

}

- (void)actionViewWithText:(NSString *)text{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:text delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
