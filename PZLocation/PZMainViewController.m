//
//  PZMainViewController.m
//  PZLocation
//
//  Created by 赵朋 on 16/7/26.
//  Copyright © 2016年 赵朋. All rights reserved.
//

#import "PZMainViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface PZMainViewController ()<CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;
    
    CLGeocoder *_geocoder;

}

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;

@end

@implementation PZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self bulidUI];
    
    _locationManager = [[CLLocationManager alloc] init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        [self actionViewWithText:@"定位未打开"];
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];

    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        
        _locationManager.delegate = self;
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        CLLocationDistance distance=0.1;
        
        _locationManager.distanceFilter = distance;
        
        [_locationManager startUpdatingLocation];
    
    }
    
    
    _geocoder = [[CLGeocoder alloc] init];
    
    // Do any additional setup after loading the view.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations firstObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"经度：%f，，，，维度：%f，，，，，海拔：%f，，，，，航向：%f，，，，行走速度：%f", coordinate.longitude, coordinate.latitude,location.altitude,location.course,location.speed);
    
    self.label3.text = [NSString stringWithFormat:@"%f",coordinate.latitude];
    self.label4.text = [NSString stringWithFormat:@"%f",coordinate.longitude];
    
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
//    [_locationManager stopUpdatingLocation];
}


- (void) getCoordinateByAddress:(NSString *)address{
    
    self.label1.text = @" ";
    self.label2.text = @" ";
    
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        CLPlacemark *placemark = [placemarks firstObject];
        
        CLLocation *location = placemark.location;
        
        CLRegion *region = placemark.region;
        
        NSDictionary *addressDic = placemark.addressDictionary;
        
        NSLog(@"&&&&&&&&&&&&&&location == %@,,,,region == %@,,,,,,addressDic == %@",location,region,addressDic);
        
        CLLocationCoordinate2D coordinate = location.coordinate;
        
        
        self.label1.text = [NSString stringWithFormat:@"%f",coordinate.latitude];
        self.label2.text = [NSString stringWithFormat:@"%f",coordinate.longitude];
        
    }];

}

- (void) getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        CLPlacemark *placemark = [placemarks firstObject];
        NSLog(@"************************%@",placemark.addressDictionary);
        
        [self getCoordinateByAddress:[placemark.addressDictionary objectForKey:@"City"]];
        
        self.label.text = [placemark.addressDictionary objectForKey:@"City"];
    }];



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionViewWithText:(NSString *)text{

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:text delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)bulidUI{
    self.label = ({
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
        
        lab.backgroundColor = [UIColor yellowColor];
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab;
    });
    [self.view addSubview:self.label];
    
    self.label1 = ({
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 30)];
        
        lab.backgroundColor = [UIColor yellowColor];
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab;
    });
    [self.view addSubview:self.label1];
    
    self.label2 = ({
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 100, 30)];
        
        lab.backgroundColor = [UIColor yellowColor];
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab;
    });
    [self.view addSubview:self.label2];
    
    self.label3 = ({
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 400, 100, 30)];
        
        lab.backgroundColor = [UIColor yellowColor];
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab;
    });
    [self.view addSubview:self.label3];
    
    self.label4 = ({
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(200, 400, 100, 30)];
        
        lab.backgroundColor = [UIColor yellowColor];
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab;
    });
    [self.view addSubview:self.label4];

}

@end
