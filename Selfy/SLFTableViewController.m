//
//  SLFTableViewController.m
//  Selfy
//
//  Created by Austin Nolan on 4/21/14.
//  Copyright (c) 2014 Austin Nolan. All rights reserved.
//

#import "SLFTableViewController.h"

#import "SLFTableViewCell.h"

#import "SLFSelfyViewController.h"

#import "SLFNewNavigationController.h"

#import "SLFSettingsButton.h"

#import "SLFSettingsViewController.h"

#import <Parse/Parse.h>



@interface SLFTableViewController () <SLFSelfyViewControllerDelegate>

@end

@implementation SLFTableViewController



{
    
    UIView * header;
    //UIButton * settingsButton;
    UIButton * addNewButton;
    UILabel * headerTitle;
    NSArray * profiles;
    
    SLFSettingsButton * settingsView;
    
    SLFSettingsViewController * settingsVC;
    
    
}


-(void)addNewSelfy: (NSDictionary *)newSelfy

{
   //NSLog("New selfy, %@", newSelfy[@"caption"]);
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    
//        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
//        header.backgroundColor = [UIColor grayColor];
//        self.tableView.tableHeaderView = header;
        
        
        headerTitle = [[UILabel alloc]initWithFrame:CGRectMake(160, 20, 100, 30)];
        headerTitle.text = @"Selfy";
        [header addSubview:headerTitle];
        
        
//        settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 80, 30)];
//        settingsButton.backgroundColor = [UIColor redColor];
//        settingsButton.layer.cornerRadius = 5;
//        
//        [settingsButton setTitle:@"settings"forState:UIControlStateNormal];
//        [header addSubview:settingsButton];

        
        
        addNewButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, 80, 30)];
        addNewButton.backgroundColor = [UIColor greenColor];
        addNewButton.layer.cornerRadius = 5;
        
        [addNewButton setTitle:@"Add New"forState:UIControlStateNormal];
        //[addNewButton addTarget:self action:createNewUser forControlEvents:UIControlEventTouchUpInside];
        
        
        [header addSubview:addNewButton];
        
//        profiles = @[
//                     @{@"image":@"https://pbs.twimg.com/media/BlWSbUeCAAAWfrY.jpg",
//                       @"caption":@"Caption",
//                       @"USER_ID":@"User1 ID",
//                       @"avatar":@"http://m.c.lnkd.licdn.com/mpr/pub/image-WdGsCMceaQX0Eo5wC8gTIjzkQeWPka-WddbNI12iQ5T9PAB7WdGNczreQJ6PkIAju9xd/austin-nolan.jpg",
//                       @"SELFY_ID": @""
//                       },
//                     @{@"image":@"URL",
//                       @"caption":@"Caption",
//                       @"USER_ID":@"User2 ID",
//                       @"avatar":@"Image URL"
//                       },
//                     @{@"image":@"URL",
//                       @"caption":@"Caption",
//                       @"USER_ID":@"User3 ID",
//                       @"avatar":@"Image URL"
//                       }];
        

//        [self refreshSelfies];
        
        
//        
//        PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//        testObject[@"foo"] = @"bar";
//        [testObject saveInBackground];
//        
//        PFUser * user = [PFUser currentUser];
//        
//        user.username = @"AustinNolan";
//        user.password = @"Password";
//        
//        [user saveInBackground];
        
        
       
        self.tableView.rowHeight = self.tableView.frame.size.width;
        
        
    }
    return self;
}


-(void)createNewUser
{

    SLFSelfyViewController * newSelfyVC = [[SLFSelfyViewController alloc] initWithNibName:nil bundle:nil];
    
    
    SLFNewNavigationController * nc = [[SLFNewNavigationController alloc] initWithRootViewController:newSelfyVC];
    
    
    nc.navigationBar.barTintColor = [UIColor blueColor];
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
    
    
    }];

}


-(void)settingsMenu
{
  
    [settingsView toggle];
    
    int X = [settingsView isToggled] ? SCREEN_WIDTH -50 : 0;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.navigationController.view.frame = CGRectMake(X, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    }completion:^(BOOL finished) {
        
        if(![settingsView isToggled])
        {
            [settingsVC.view removeFromSuperview];
        }
    }];
    
    if([settingsView isToggled])
    {
    settingsVC = [[SLFSettingsViewController alloc] initWithNibName:nil bundle:nil];
        settingsVC.view.frame = CGRectMake(50 - SCREEN_WIDTH, 0, SCREEN_WIDTH-50, SCREEN_HEIGHT);
        
        [self.navigationController.view addSubview:settingsVC.view];
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    //Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem * addNewSelfyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewUser)];
    
    self.navigationItem.rightBarButtonItem = addNewSelfyButton;
    
    
    
    
    settingsView = [[SLFSettingsButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    [settingsView addTarget:self action:@selector(settingsMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * settingsButton = [[UIBarButtonItem alloc] initWithCustomView:settingsView];

    settingsView.toggledTintColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = settingsButton;
    
    
    
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [self refreshSelfies];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//    PFQuery * query =[PFQuery queryWithClassName:@"UserSelfy"];
//    
//    profiles =  [query findObjects];
    
//    NSLog(@"%@",profiles);
//    
//    for (PFObject * userSelfy in profiles)
//    
//    {
//        NSLog (@"image: %@", [userSelfy objectForKey:@"image"]);
//    }
    
    
   
    return [profiles count];
}

-(void)refreshSelfies
{
    PFQuery * query =[PFQuery queryWithClassName:@"UserSelfy"];
    
    //change order by created date
    [query orderByDescending:@"createdAt"];
    
    //filter only your user's selfies
    [query whereKey:@"parent" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    
    
        profiles = objects;
        
        [self.tableView reloadData];
    
    }];


    // change order by created date : newest first
    // after user connected to selfy : filter only your user's selfies
    
    
    
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    TDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) cell = [[ TDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    cell.profileInfo = [self getListItem:indexPath.row];
//    return cell;
    
    
    
    
    SLFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) cell =[[SLFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    
//    cell.profiles = [self getListItem:indexPath.row];
    
    
    
    
    
    
    NSDictionary *profile = profiles[indexPath.row];
    
    //NSString * cell = @"cell";
    
    
    cell.profile = profile;
        
//    cell.textLabel.text = profile[@"USER_ID"];
    
//    cell.detailTextLabel.text = profile[@"caption"];
    
    //NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
