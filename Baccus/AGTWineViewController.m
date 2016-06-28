//
//  AGTWineViewController.m
//  Baccus
//
//  Created by Fernando Rodríguez Romero on 1/30/13.
//  Copyright (c) 2013 Agbo. All rights reserved.
//

#import "AGTWineViewController.h"

@implementation AGTWineViewController

- (id)initWithModel:(AGTWineModel *)aModel
{    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = aModel;
        self.title = aModel.name;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self syncViewToModel];
}


#pragma mark - Actions

- (IBAction)displayWebpage:(id)sender
{    
    NSLog(@"Goto website: %@", self.model.wineCompanyWeb);
}


#pragma mark - Utils

- (void)clearRatings
{    
    for (UIImageView *each in self.ratingViews) {
        each.image = nil;
    }
}

- (void)displayRating:(int)aRatingValue
{
    [self clearRatings];
    
    UIImage *glass = [UIImage imageNamed:@"splitView_score_glass@2x.png"];
    
    for (int i = 0; i < aRatingValue; i++) {        
        [[self.ratingViews objectAtIndex:i] setImage:glass];
    }
}

- (void)syncViewToModel
{    
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = self.model.type;
    self.originLabel.text = self.model.origin;
    self.wineryNameLabel.text = self.model.wineCompanyName;
    self.notesLabel.text = self.model.notes;
    [self.notesLabel setNumberOfLines:0];
    self.photoView.image = self.model.photo;
    self.grapesLabel.text = [self arrayToString:self.model.grapes];
    [self displayRating:self.model.rating];
    self.webButton.enabled = (BOOL)self.model.wineCompanyWeb;
    
}

- (NSString *)arrayToString:(NSArray *)anArray
{    
    NSString *repr;
    
    if ([anArray count] == 1) {
        repr = [@"100% " stringByAppendingString: [anArray lastObject]];
    }
    else {
        repr = [[anArray componentsJoinedByString:@", "] stringByAppendingString:@"."];
    }
    
    return repr;
}

@end