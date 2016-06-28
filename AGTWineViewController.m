//
//  AGTWineViewController.m
//  Baccup
//
//  Created by Alicia Daza on 23/02/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import "AGTWineViewController.h"
#import "AGTWebViewController.h"

@implementation AGTWineViewController

#pragma mark -  Init

- (id)initWithModel:(AGTWineModel *)aModel
{
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = aModel;
        self.title = aModel.wineCompanyName;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self syncModelAndView];
    
    //Fix tapado
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.5 green:0 blue:0.7 alpha:0.5];
    //self.navigationController.navigationBar.translucent = NO;
    //self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.5 green:0 blue:0.7 alpha:0.5];
    
    /*iOS8*/
    if(self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryHidden){
        
        self.navigationItem.rightBarButtonItem = self.splitViewController.displayModeButtonItem;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)displayWeb:(id)sender{
    /*
    NSLog(@"Ahora se mostraría la web: %@", self.model.wineCompanyWeb);
    NSLog(@"Goto website: %@", self.model.wineCompanyWeb);
     */
    //Crear un webViewController
    AGTWebViewController *webVC = [[AGTWebViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Utils

- (void)syncModelAndView
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
    
    [self.notesLabel setNumberOfLines:0];
    
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

#pragma  mark - UISplitViewControllerDelegate

-(void) splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    
    if(displayMode == UISplitViewControllerDisplayModePrimaryHidden){
        
        self.navigationItem.rightBarButtonItem = svc.displayModeButtonItem;
    } else if(displayMode == UISplitViewControllerDisplayModeAllVisible){
        
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark -  AGTWineryTableViewControllerDelegate

- (void)wineryTableViewController:(AGTWineryTableViewController *)aWineryVC
                    didSelectWine:(AGTWineModel *)aWine
{
    self.model = aWine;
    self.title = aWine.name;
    [self syncModelAndView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
