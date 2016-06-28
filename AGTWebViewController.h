//
//  AGTWebViewController.h
//  Baccup
//
//  Created by Alicia Daza on 24/02/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTWineModel.h"

@interface AGTWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) AGTWineModel *model;
@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;


-(id) initWithModel: (AGTWineModel *) aModel;

@end
