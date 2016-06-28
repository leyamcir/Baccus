//
//  AppDelegate.m
//  Baccup
//
//  Created by Alicia Daza on 21/02/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTWineModel.h"
#import "AGTWineViewController.h"
#import "AGTWebViewController.h"
#import "AGTWineryModel.h"
#import "AGTWineryTableViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
  /*
    AGTWineModel *tintorro = [AGTWineModel wineWithName:@"Bembibre"
                                        wineCompanyName:@"Dominio de Tares"
                                                   type:@"tinto"
                                                 origin:@"El Bierzo"
                                                 grapes:@[@"Mencía"]
                                         wineCompanyWeb:[NSURL URLWithString:@"http://www.dominiodetares.com/index.php/es/vinos/baltos/74-bembibrevinos"]
                                                  notes:@"Este vino muestra toda la complejidad y la elegancia de la variedad Mencía. En fase visual luce un color rojo picota muy cubierto con tonalidades violáceas en el menisco. En nariz aparecen recuerdos frutales muy intensos de frutas rojas (frambuesa, cereza) y una potente ciruela negra, así como tonos florales de la gama de las rosas y violetas, vegetales muy elegantes y complementarios, hojarasca verde, tabaco y maderas aromáticas (sándalo) que le brindan un toque ciertamente perfumado."
                                                 rating:5
                                                  photo:[UIImage imageNamed:@"bembibre.jpg"]];
   */
    //Controladores
    //AGTWineViewController *wineVC = [[AGTWineViewController alloc] initWithModel:tintorro];
    
    //AGTWebViewController *webVC = [[AGTWebViewController alloc] initWithModel:tintorro];
    
    /*
    //Combinador uitabbar
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[wineVC, webVC];
    */
    
    
    
    
    //Combinador uinavigationcontroller
    //UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:wineVC];
    
    
    //self.window.rootViewController = wineVC;
    
    
    //NEW
    AGTWineryModel *winery = [[AGTWineryModel alloc] init];
    
    AGTWineryTableViewController *wineryVC = [[AGTWineryTableViewController alloc] initWithModel:winery style:UITableViewStylePlain];
    /*2*/
    AGTWineViewController *wineVC = [[AGTWineViewController alloc] initWithModel:[winery redWineAtIndex:0]];
    
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    /*2*/
    UINavigationController *wineNav = [[UINavigationController alloc] initWithRootViewController:wineVC];
    
    /*2*/
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[wineryNav, wineNav];
    
    /*2*/
    //Asignamos delegado
    splitVC.delegate = wineVC;
    wineryVC.delegate = wineVC;
    
    
    self.window.rootViewController = splitVC;
    
    //self.window.backgroundColor = [UIColor blueColor];
    [self.window makeKeyAndVisible];
    //self.window.rootViewController = [UIViewController new];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
