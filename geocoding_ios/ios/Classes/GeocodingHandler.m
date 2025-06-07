//
//  GeocodingHandler.m
//  geocoding
//
//  Created by Maurits van Beusekom on 07/06/2020.
//

#import "GeocodingHandler.h"

@implementation GeocodingHandler {
    CLGeocoder* _geocoder;
}

- (id)init {
    self = [super init];
    
    if (self) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    
    return self;
}

- (void) geocodeFromAddress: (NSString *)address
                     locale: (NSLocale *)locale
                       sLat: (CGFloat) sLat
                       wLng: (CGFloat) sLng
                       nLat: (CGFloat) nLat
                       eLng: (CGFloat) nLng
                    success: (GeocodingSuccess)successHandler
                    failure: (GeocodingFailure)failureHandler {
    
    if (address == nil) {
        failureHandler(@"ARGUMENT_ERROR", @"Please supply a valid string containing the address to lookup");
        return;
    }

    CLRegion* region;
    if (sLat == 0 || sLng == 0 || nLat == 0 || nLng == 0){
        region = nil;
    }else{
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(sLat + (nLat-sLat) / 2, sLng + (nLng-sLng) / 2);
        //Computing the radius based on lat delta, since 1 lat = 111 km no matter the location
        float latDelta = nLat - sLat;
        float radiusLat = (latDelta/2);
        float radius = radiusLat * 111000;
        region = [[CLCircularRegion alloc] initWithCenter:center radius:radius identifier:@"Search Radius"];
    }

    [_geocoder geocodeAddressString:address
                           inRegion:region
                    preferredLocale:locale
                  completionHandler:^(NSArray< CLPlacemark *> *__nullable placemarks, NSError *__nullable error)
     {
        [GeocodingHandler completeGeocodingWith:placemarks
                                          error:error
                                        success:successHandler
                                        failure:failureHandler];
    }];
    return;
}

- (void) geocodeToAddress: (CLLocation *)location
                   locale: (NSLocale *)locale
                  success: (GeocodingSuccess)successHandler
                  failure: (GeocodingFailure)failureHandler  {
    [_geocoder reverseGeocodeLocation:location
                      preferredLocale:locale
                    completionHandler:^(NSArray< CLPlacemark *> *__nullable placemarks, NSError *__nullable error) {
        [GeocodingHandler completeGeocodingWith:placemarks
                                          error:error
                                        success:successHandler
                                        failure:failureHandler];
    }];
}

+ (void) completeGeocodingWith: (NSArray<CLPlacemark *> *) placemarks
                         error: (NSError *) error
                       success: (GeocodingSuccess)successHandler
                       failure: (GeocodingFailure) failureHandler {
    if (error != nil) {
        if(error.code == kCLErrorGeocodeFoundNoResult){
            failureHandler(@"NOT_FOUND", @"Could not find any result for the supplied address or coordinates.");
        } else {
            failureHandler(@"IO_ERROR", error.description);
        }
    } else if (placemarks == nil) {
        failureHandler(@"NOT_FOUND", @"Could not find any result for the supplied address or coordinates.");
    } else {
        successHandler(placemarks);
    }
}


+ (NSString *) languageCode:(NSLocale *)locale {
    return [locale languageCode];
}
@end
