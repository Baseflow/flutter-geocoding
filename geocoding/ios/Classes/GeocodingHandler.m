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
                    success: (GeocodingSuccess)successHandler
                    failure: (GeocodingFailure)failureHandler {
    
    if (address == nil) {
        failureHandler(@"ARGUMENT_ERROR", @"Please supply a valid string containing the address to lookup");
        return;
    }
    
    if (@available(iOS 11.0, *)) {
        [_geocoder geocodeAddressString:address
                               inRegion:nil
                        preferredLocale:locale
                      completionHandler:^(NSArray< CLPlacemark *> *__nullable placemarks, NSError *__nullable error)
         {
            [GeocodingHandler completeGeocodingWith:placemarks
                                              error:error
                                            success:successHandler
                                            failure:failureHandler];
        }];
    } else {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSArray<NSString * > *defaultLanguages;
        
        if (locale != nil) {
            defaultLanguages = [standardUserDefaults arrayForKey:@"AppleLanguages"];
            [standardUserDefaults setValue:[GeocodingHandler languageCode:locale]
                                    forKey:@"AppleLanguages"];
        }
        
        [_geocoder geocodeAddressString:address
                      completionHandler:^(NSArray< CLPlacemark *> *__nullable placemarks, NSError *__nullable error) {
            
            [GeocodingHandler completeGeocodingWith:placemarks
                                              error:error
                                            success:successHandler
                                            failure:failureHandler];
            
            if (locale != nil) {
                [standardUserDefaults setValue:defaultLanguages
                                        forKey:@"AppleLanguages"];
            }
        }];
    }
    
    return;
}

- (void) geocodeToAddress: (CLLocation *)location
                   locale: (NSLocale *)locale
                  success: (GeocodingSuccess)successHandler
                  failure: (GeocodingFailure)failureHandler  {
    
    if (@available(iOS 11.0, *)) {
        [_geocoder reverseGeocodeLocation:location
                          preferredLocale:locale
                        completionHandler:^(NSArray< CLPlacemark *> *__nullable placemarks, NSError *__nullable error) {
            [GeocodingHandler completeGeocodingWith:placemarks
                                              error:error
                                            success:successHandler
                                            failure:failureHandler];
        }];
        
    } else {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSArray<NSString * > *defaultLanguages;
        
        if (locale != nil) {
            defaultLanguages = [standardUserDefaults arrayForKey:@"AppleLanguages"];
            [standardUserDefaults setValue:[GeocodingHandler languageCode:locale]
                                    forKey:@"AppleLanguages"];
        }
        
        [_geocoder reverseGeocodeLocation:location
                        completionHandler:^(NSArray< CLPlacemark *> *__nullable placemarks, NSError *__nullable error) {
            [GeocodingHandler completeGeocodingWith:placemarks
                                              error:error
                                            success:successHandler
                                            failure:failureHandler];
            
            if (locale != nil) {
                [standardUserDefaults setValue:defaultLanguages forKey:@"AppleLanguages"];
            }
        }];
    }
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
    if (@available(iOS 10.0, *)) {
        return [locale languageCode];
    } else {
        return [[locale localeIdentifier] substringToIndex:2];
    }
}
@end
