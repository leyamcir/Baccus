//
//  AGTWineryTableViewController.h
//  Baccup
//
//  Created by Alicia Daza on 26/02/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTWineryModel.h"

#define RED_WINE_SECTION 0
#define WHITE_WINE_SECTION 1
#define OTHER_WINE_SECTION 2

#define NEW_WINE_NOTIFICATION_NAME @"newWineSelected"
#define WINE_KEY @"wine"

#define SECTION_KEY @"section"
#define ROW_KEY @"row"
#define LAST_WINE_KEY @"lastWine"

@class AGTWineryTableViewController;

@protocol WineryTableViewControllerDelegate <NSObject>

- (void)wineryTableViewController:(AGTWineryTableViewController *)aWineryVC
                    didSelectWine:(AGTWineModel *)aWine;

@end


@interface AGTWineryTableViewController : UITableViewController <WineryTableViewControllerDelegate>

@property (strong, nonatomic) AGTWineryModel *model;
@property (weak, nonatomic) id<WineryTableViewControllerDelegate> delegate;


-(id) initWithModel: (AGTWineryModel *) aModel
              style: (UITableViewStyle) aStyle;

- (AGTWineModel *)lastSelectedWine;

@end
