//
//  AGTWineryTableViewController.m
//  Baccup
//
//  Created by Alicia Daza on 26/02/16.
//  Copyright © 2016 Alicia Daza. All rights reserved.
//

#import "AGTWineryTableViewController.h"
#import "AGTWineViewController.h"

@interface AGTWineryTableViewController ()

@end

@implementation AGTWineryTableViewController

-(id) initWithModel: (AGTWineryModel *) aModel
              style: (UITableViewStyle) aStyle{
    if (self = [super initWithStyle:aStyle]) {
        _model = aModel;
        self.title = @"Baccup";
    }
    
    return self;
}

-(void) viewWillAppear: (BOOL) animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.5 green:0 blue:0.7 alpha:0.5];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section{
    if (section == RED_WINE_SECTION) {
        return @"Red wines";
    }else if (section == WHITE_WINE_SECTION) {
        return @"White wines";
    }else if (section == OTHER_WINE_SECTION) {
        return @"Other wines";
    }else {
        return @"Other wines";
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == RED_WINE_SECTION) {
        return self.model.redWineCount;
    }else if (section == WHITE_WINE_SECTION) {
        return self.model.whiteWineCount;
    }else if (section == OTHER_WINE_SECTION) {
        return self.model.otherWineCount;
    }else {
        return self.model.otherWineCount;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        // Create cell
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle)
                                      reuseIdentifier:cellIdentifier];
    }
    
    // Sync model and cell
    AGTWineModel *wine = nil;
    if (indexPath.section == RED_WINE_SECTION) {
        wine = [self.model redWineAtIndex:indexPath.row];
    }
    else if (indexPath.section == WHITE_WINE_SECTION) {
        wine = [self.model whiteWineAtIndex:indexPath.row];
    }
    else {
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    cell.imageView.image = wine.photo;
    cell.textLabel.text = wine.name;
    cell.detailTextLabel.text = wine.wineCompanyName;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Escogemos el vino seleccionado
    AGTWineModel *wine = nil;
    
    if (indexPath.section == RED_WINE_SECTION) {
        wine = [self.model redWineAtIndex:indexPath.row];
    }
    else if (indexPath.section == WHITE_WINE_SECTION) {
        wine = [self.model whiteWineAtIndex:indexPath.row];
    }
    else {
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    /*OLD
    // Cargamos el controlador
    AGTWineViewController *wineVC = [[AGTWineViewController alloc] initWithModel:wine];
    
    // Lo insertamos en la jerarquia si estamos en un UINavigationController
    [self.navigationController pushViewController:wineVC animated:YES];
     */
    
    [self.delegate wineryTableViewController:self didSelectWine:wine];
    
    //Notification
    NSNotification *n = [NSNotification notificationWithName:NEW_WINE_NOTIFICATION_NAME object:self userInfo:@{WINE_KEY: wine}];
    [[NSNotificationCenter defaultCenter] postNotification: n];
    
}

#pragma mark - AGTWineryTableViewControllerDelegate

-(void) wineryTableViewController:(AGTWineryTableViewController *)aWineryVC
                    didSelectWine:(AGTWineModel *)aWine{
    AGTWineViewController *wineVC = [[AGTWineViewController alloc] initWithModel:aWine];
    
    [self.navigationController pushViewController:wineVC animated:YES];
}

#pragma mark -  Utils

- (AGTWineModel *)wineForIndexPath:(NSIndexPath *)indexPath
{
    AGTWineModel *wine = nil;
    
    if (indexPath.section == RED_WINE_SECTION) {
        wine = [self.model redWineAtIndex:indexPath.row];
    }
    else if (indexPath.section == WHITE_WINE_SECTION) {
        wine = [self.model whiteWineAtIndex:indexPath.row];
    }
    else {
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    return wine;
}


#pragma mark -  NSUserDefaults

- (NSDictionary *)setDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Por defecto, mostraremos el primero de los tintos
    NSDictionary *defaultWineCoords = @{SECTION_KEY : @(RED_WINE_SECTION), ROW_KEY : @0};
    
    // lo asignamos
    [defaults setObject:defaultWineCoords
                 forKey:LAST_WINE_KEY];
    // guardamos por si las moscas
    [defaults synchronize];
    
    return defaultWineCoords;
    
}

- (void)saveLastSelectedWineAtSection:(NSUInteger)section row:(NSUInteger)row
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@{SECTION_KEY : @(section),
                          ROW_KEY     : @(row)}
                 forKey:LAST_WINE_KEY];
    
    [defaults synchronize];
}

- (AGTWineModel *)lastSelectedWine
{
    NSIndexPath *indexPath = nil;
    NSDictionary *coords = nil;
    
    coords = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WINE_KEY];
    
    if (coords == nil) {
        // Primera vez
        coords = [self setDefaults];
    }
    
    indexPath = [NSIndexPath indexPathForRow:[[coords objectForKey: ROW_KEY] integerValue]
                                   inSection:[[coords objectForKey: SECTION_KEY] integerValue]];
    
    return [self wineForIndexPath:indexPath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
