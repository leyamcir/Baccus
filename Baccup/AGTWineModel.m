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

// Inicializador designado
- (id)initWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineryName
              type:(NSString *)aType
            origin:(NSString *)anOrigin
            grapes:(NSArray *)arrayOfGrapes
    wineCompanyWeb:(NSURL *)aURL
             notes:(NSString *)aNotes
            rating:(int)aRating
             photo:(UIImage *)aPhoto{
    if (self = [super init]) {
        <#statements#>
    }
}

@end