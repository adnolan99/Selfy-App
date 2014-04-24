//
//  SLFViewController.m
//  Selfy
//
//  Created by Austin Nolan on 4/22/14.
//  Copyright (c) 2014 Austin Nolan. All rights reserved.
//

#import "SLFLoginController.h"

#import "SLFTableViewController.h"

#import <Parse/Parse.h>


@interface SLFLoginController ()

@end

@implementation SLFLoginController

{
    UITextField * userName;
    
    UITextField * password;
    
    UIButton * submitButton;
    
    UIView * loginForm;

}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        
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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    loginForm = [[UIView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:loginForm];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    imageView.backgroundColor = [UIColor yellowColor];
    [loginForm addSubview:imageView];
    
    userName = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 100, 20)];
    userName.backgroundColor = [UIColor orangeColor];
    userName.layer.cornerRadius = 10;
    userName.placeholder = @"Username";
    userName.tintColor = [UIColor lightGrayColor];
    [userName resignFirstResponder];
    [self.view addSubview:userName];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, 100, 20)];
    password.backgroundColor = [UIColor blueColor];
    password.layer.cornerRadius = 10;
    password.secureTextEntry =YES;
    password.placeholder = @"Password";
    password.tintColor = [UIColor lightGrayColor];
    [self.view addSubview:password];

    
    submitButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, 100, 20)];
    submitButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:.05];
    submitButton.layer.cornerRadius = 10;
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    submitButton.tintColor = [UIColor lightGrayColor];
    [submitButton addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    
    // Do any additional setup after loading the view.
}

-(void)userLogin
     {
         PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
         testObject[@"Username"] = @"bar";
         [testObject saveInBackground];
         
         PFUser * user = [PFUser currentUser];
         
         user.username = userName.text;
         user.password = password.text;
         
         userName.text = nil;
         password.text = nil;
         
         
         [userName resignFirstResponder];
         [password resignFirstResponder];
         
         //[UIActivityIndicatorView
         // start...
         // addSubview
         // run method
         
         UIActivityIndicatorView *activityIndicator;
         activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
         activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
         activityIndicator.center = self.view.center;
         [activityIndicator startAnimating];
         [self.view addSubview: activityIndicator];
         
         
         [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
             
             if (error == nil)
             {
    
                 self.navigationController.navigationBarHidden = NO;
                 self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
             }
             else
             {
              
                 
                 
//                 
//                 UIAlertView * alert;
//                 error.userInfo[@"error"];

                 
                 // activity indicator remove
             }
             
             
         }];
         
         NSLog(@"Submitting");
     }
     
     

- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.4 animations:^{
        loginForm.frame = CGRectMake(0, -150, 320, self.view.frame.size.height);
    }];
    return YES;
}



     
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
