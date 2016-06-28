//
//  AGTWebViewController.m
//  Baccup
//
//  Created by Alicia Daza on 24/02/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import "AGTWebViewController.h"
#import "AGTWineryTableViewController.h"

@interface AGTWebViewController ()

@end

@implementation AGTWebViewController


-(id) initWithModel: (AGTWineModel *) aModel{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = aModel;
        self.title = @"Web";
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self displayURL: self.model.wineCompanyWeb];
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(wineDidChange:)
                   name:NEW_WINE_NOTIFICATION_NAME
                 object:nil];
}

- (void) viewWillDisppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void) wineDidChange: (NSNotification *) notification{
    NSDictionary *dict = [notification userInfo];
    AGTWineModel *newWine = [dict objectForKey: WINE_KEY];
    
    self.model = newWine;
    [self displayURL:self.model.wineCompanyWeb];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils

-(void) displayURL: (NSURL *) aUrl{
    self.browser.delegate = self;
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    
    [self.browser loadRequest:[NSURLRequest requestWithURL: aUrl]];
    
    
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
