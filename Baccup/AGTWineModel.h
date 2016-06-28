//
//  AGTWineModel.h
//  Baccup
//
//  Created by Alicia Daza on 21/02/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGTWineModel: NSObject

// Propiedades
@property (copy, nonatomic) NSString *type;
@property (strong, nonatomic) UIImage *photo;
@property (strong, nonatomic) NSURL *wineCompanyWeb;
@property (copy, nonatomic) NSString *notes;
@property (copy, nonatomic) NSString *origin;
@property (nonatomic) int rating; // 0 to 5
@property (strong, nonatomic) NSArray *grapes;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *wineCompanyName;

// Inicializador designado
- (id)initWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineryName
              type:(NSString *)aType
            origin:(NSString *)anOrigin
            grapes:(NSArray *)arrayOfGrapes
    wineCompanyWeb:(NSURL *)aURL
             notes:(NSString *)aNotes
            rating:(int)aRating
             photo:(UIImage *)aPhoto;

@end