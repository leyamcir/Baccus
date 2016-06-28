//
//  AGTWineModel.m
//  Baccup
//
//  Created by Alicia Daza on 21/02/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AGTWineModel.h"

@implementation AGTWineModel

@synthesize photo = _photo;

#pragma mark - Propiedades
-(UIImage *)photo{
    if (_photo == nil) {
        _photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoURL]];
    }
    return _photo;
}

#pragma mark - Métodos de clase
+ (id)wineWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineryName
              type:(NSString *)aType
            origin:(NSString *)anOrigin
            grapes:(NSArray *)arrayOfGrapes
    wineCompanyWeb:(NSURL *)aURL
             notes:(NSString *)aNotes
            rating:(int)aRating
          photoURL:(NSURL *)aPhotoURL
{
    return [[self alloc] initWithName:aName
                      wineCompanyName:aWineryName
                                 type:aType
                               origin:anOrigin
                               grapes:arrayOfGrapes
                       wineCompanyWeb:aURL
                                notes:aNotes
                               rating:aRating
                             photoURL:aPhotoURL];
}

+ (id)wineWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineryName
              type:(NSString *)aType
            origin:(NSString *)anOrigin
{
    return [[self alloc] initWithName:aName
                      wineCompanyName:aWineryName
                                 type:aType
                               origin:anOrigin];
}


#pragma mark - Init

// Inicializador designado
- (id)initWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineryName
              type:(NSString *)aType
            origin:(NSString *)anOrigin
            grapes:(NSArray *)arrayOfGrapes
    wineCompanyWeb:(NSURL *)aURL
             notes:(NSString *)aNotes
            rating:(int)aRating
          photoURL:(NSURL *)aPhotoURL
{
    if (self = [super init]) {
        _name = aName;
        _wineCompanyName = aWineryName;
        _type = aType;
        _origin = anOrigin;
        _grapes = arrayOfGrapes;
        _wineCompanyWeb = aURL;
        _notes = aNotes;
        _rating = aRating;
        _photoURL = aPhotoURL;
    }
    
    return self;
}

- (id)initWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineryName
              type:(NSString *)aType
            origin:(NSString *)anOrigin
{
    return [self initWithName:aName
              wineCompanyName:aWineryName
                         type:aType
                       origin:anOrigin
                       grapes:nil
               wineCompanyWeb:nil
                        notes:nil
                       rating:NO_RATING
                        photoURL:nil];
}

#pragma mark - JSON

-(id) initWithDictionary:(NSDictionary *)aDict{
    
    return [self initWithName:[aDict objectForKey:@"name"]
              wineCompanyName:[aDict objectForKey:@"wineCompanyName"]
                         type:[aDict objectForKey:@"type"]
                       origin:[aDict objectForKey:@"origin"]
                       grapes:[self extractGrapesFromJSONArray:[aDict objectForKey:@"grapes"]]
               wineCompanyWeb:[NSURL URLWithString:[aDict objectForKey:@"wine_web"]]    //fix/11a
                        notes:[aDict objectForKey:@"notes"]
                       rating:[[aDict objectForKey:@"rating"] intValue]
                     photoURL:[NSURL URLWithString:[aDict objectForKey:@"picture"]]];
}

-(NSDictionary *)proxyForJSON{
    
    return @{@"name"            : self.name,
             @"wineCompanyName" : self.wineCompanyName,
             @"wine_web"        : [self.wineCompanyWeb path], //fix/11a
             @"type"            : self.type,
             @"origin"          : self.origin,
             @"grapes"          : self.grapes,
             @"notes"           : self.notes,
             @"rating"          : @(self.rating),
             @"picture"        : [self.photoURL path]};
}


#pragma mark - Utils
-(NSArray*)extractGrapesFromJSONArray: (NSArray*)JSONArray{
    
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    
    for (NSDictionary *dict in JSONArray) {
        [grapes addObject:[dict objectForKey:@"grape"]];
    }
    
    return grapes;
}

-(NSArray *)packGrapesIntoJSONArray{
    
    NSMutableArray *jsonArray = [NSMutableArray arrayWithCapacity:[self.grapes count]];
    
    for (NSString *grape in self.grapes) {
        
        [jsonArray addObject:@{@"grape": grape}];
    }
    
    return jsonArray;
    
}


@end