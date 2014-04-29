//
//  SLFViewController.m
//  Selfy
//
//  Created by Austin Nolan on 4/22/14.
//  Copyright (c) 2014 Austin Nolan. All rights reserved.
//

#import "SLFLoginController.h"

#import "SLFTableViewController.h"

#import "SLFSignUpViewController.h"

#import "SLFNewNavigationController.h"

#import <Parse/Parse.h>


@interface SLFLoginController ()

@end

@implementation SLFLoginController

{
    UITextField * userName;
    
    UITextField * password;
    
    UIButton * submitButton;
    
    UIButton * signUpButton;
    
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
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [loginForm addSubview:imageView];
    
    userName = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 100, 20)];
    userName.backgroundColor = [UIColor colorWithWhite:0.1 alpha:.05];
    userName.layer.cornerRadius = 10;
    userName.placeholder = @"Username";
    userName.tintColor = [UIColor lightGrayColor];
    [userName resignFirstResponder];
    [self.view addSubview:userName];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(20, 90, 100, 20)];
    password.backgroundColor = [UIColor colorWithWhite:0.1 alpha:.05];
    password.layer.cornerRadius = 10;
    password.secureTextEntry =YES;
    password.placeholder = @"Password";
    password.tintColor = [UIColor lightGrayColor];
    [self.view addSubview:password];

    
    submitButton = [[UIButton alloc] initWithFrame:CGRectMake(20,120, 100, 20)];
    submitButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:.05];
    submitButton.layer.cornerRadius = 10;
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    submitButton.tintColor = [UIColor lightGrayColor];
    [submitButton addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    
    
    signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(20,120, 100, 20)];

    
    signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(20,150, 100, 20)];
    signUpButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:.05];
    signUpButton.layer.cornerRadius = 10;
    [signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    signUpButton.tintColor = [UIColor lightGrayColor];
    [signUpButton addTarget:self action:@selector(showSignUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    
    // Do any additional setup after loading the view.
}




//remove auto Caps, animate login fields up if you are not already.



-(void)showSignUp
{
    
   
        
        SLFSignUpViewController * newSelfyVC = [[SLFSignUpViewController alloc] initWithNibName:nil bundle:nil];
        
        
        SLFNewNavigationController * nc = [[SLFNewNavigationController alloc] initWithRootViewController:newSelfyVC];
        
        
        nc.navigationBar.barTintColor = [UIColor blueColor];
        
        [self.navigationController presentViewController:nc animated:YES completion:^{
            
            
        }];
        
    }
    
    


-(void)userLogin
     {

         
         
         //         PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//         testObject[@"Username"] = @"bar";
//         [testObject saveInBackground];
//         
//         PFUser * user = [PFUser currentUser];
//         
//         user.username = userName.text;
//         user.password = password.text;
//         
//         userName.text = nil;
//         password.text = nil;
         
         
         UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
         activityIndicator.color= [UIColor redColor];
         activityIndicator.frame = CGRectMake(0, 10, 100, 50);
         
         [loginForm addSubview:activityIndicator];
         
         [activityIndicator startAnimating];
         
         
         [PFUser logInWithUsernameInBackground:userName.text password:password.text block:^(PFUser *user, NSError *error) {
             
             
                 if (error == nil)
                 {
                     
                     self.navigationController.navigationBarHidden = NO;
                     self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
                 }
                 else
                 {
                     
                     password.text = nil;
                     
                     [activityIndicator removeFromSuperview];
                     
                     NSString * errorDescription = error.userInfo[@"error"];
                     
                     UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"UserName Taken" message:errorDescription delegate:self cancelButtonTitle:@"Try Another Username" otherButtonTitles:nil];
                     
                     
                     [alertView show];
                     
                     //error.userInfo[@"error"]
                     //UIAlertView with message
                     
                     // activity indicator remove
                 }
                 
                 
             }];
             
         }
         
         
         
         
         
         
         //[UIActivityIndicatorView
         // start...
         // addSubview
         // run method
         
         
         
         

     
     

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
