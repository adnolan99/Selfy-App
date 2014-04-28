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
    
    UITextField * createUserName;
    
    UITextField * createPassword;
    
    UITextField * createDisplayName;
    
    UITextField * enterEmailAddress;
    
    
    
    UIButton * submitButton;
    
    UIButton * goToLoginPage;
    
    UIButton * goToSignUpPage;
    
    UIButton * createAccountButton;
    
    UIView * loginForm;
    
    UIView * signUpForm;
    
    UIView * signInOrUp;

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
    
    [self.view addSubview:signInOrUp];
    
    goToLoginPage = [[UIButton alloc] initWithFrame:CGRectMake(85,110, 150, 30)];
    goToLoginPage.backgroundColor = [UIColor blueColor];
    goToLoginPage.layer.cornerRadius = 10;
    [goToLoginPage setTitle:@"Sign In" forState:UIControlStateNormal];
    //submitButton.backgroundColor = [UIColor blueColor];
    [goToLoginPage addTarget:self action:@selector(takeMeToSignIn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goToLoginPage];
    
    
    
    
    
    goToSignUpPage = [[UIButton alloc] initWithFrame:CGRectMake(85,190, 150, 30)];
    goToSignUpPage.backgroundColor = [UIColor blueColor];
    goToSignUpPage.layer.cornerRadius = 10;
    [goToSignUpPage setTitle:@"Sign Up" forState:UIControlStateNormal];
    //goToSignUpPage.backgroundColor = [UIColor blueColor];
    [goToSignUpPage addTarget:self action:@selector(takeMeToSignUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goToSignUpPage];
    
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}



-(void)takeMeToSignIn
{
    
    loginForm = [[UIView alloc] initWithFrame:self.view.frame];

    [signInOrUp removeFromSuperview];
    
    [self.view addSubview:loginForm];
    
    
    
    
    //[self.view addSubview:loginForm];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [loginForm addSubview:imageView];
    
    userName = [[UITextField alloc] initWithFrame:CGRectMake(85, 110, 150, 30)];
    userName.backgroundColor = [UIColor colorWithWhite:0.1 alpha:.2];
    userName.layer.cornerRadius = 10;
    userName.placeholder = @"Username";
    userName.tintColor = [UIColor whiteColor];
    [userName resignFirstResponder];
    [self.view addSubview:userName];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(85, 150, 150, 30)];
    password.backgroundColor = [UIColor colorWithWhite:0.1 alpha:.2];
    password.layer.cornerRadius = 10;
    password.secureTextEntry =YES;
    password.placeholder = @"Password";
    password.tintColor = [UIColor whiteColor];
    [self.view addSubview:password];
    
    
    submitButton = [[UIButton alloc] initWithFrame:CGRectMake(85,190, 150, 30)];
    submitButton.backgroundColor = [UIColor blueColor];
    submitButton.layer.cornerRadius = 10;
    [submitButton setTitle:@"Sign In" forState:UIControlStateNormal];
    //submitButton.backgroundColor = [UIColor blueColor];
    [submitButton addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    
    
    
}


-(void)takeMeToSignUp
{
    
    //NSLog(@"Press");
    
    signUpForm = [[UIView alloc] initWithFrame:self.view.frame];

    [signInOrUp removeFromSuperview];
    
    [self.view addSubview: signUpForm];
    signUpForm.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];

    
    createUserName = [[UITextField alloc] initWithFrame:CGRectMake(85, 450, 150, 30)];
    createUserName.backgroundColor = [UIColor lightGrayColor];
    createUserName.layer.cornerRadius = 10;
    createUserName.placeholder = @"Create a Username";

    [signUpForm addSubview:createUserName];
    
    createPassword = [[UITextField alloc] initWithFrame:CGRectMake(85, 490, 150, 30)];
    createPassword.backgroundColor = [UIColor lightGrayColor];
    createPassword.layer.cornerRadius = 10;
    createPassword.placeholder = @"Create a Password";

    [signUpForm addSubview:createPassword];
    
    createDisplayName = [[UITextField alloc] initWithFrame:CGRectMake(85, 530, 150, 30)];
    createDisplayName.backgroundColor = [UIColor lightGrayColor];
    createDisplayName.layer.cornerRadius = 10;
    createDisplayName.placeholder = @"Display Name";

    [signUpForm addSubview:createDisplayName];
    
    enterEmailAddress = [[UITextField alloc] initWithFrame:CGRectMake(85, 570, 150, 30)];
    enterEmailAddress.backgroundColor = [UIColor lightGrayColor];
    enterEmailAddress.layer.cornerRadius = 10;
    enterEmailAddress.placeholder = @"Enter Your Email Address";

    [signUpForm addSubview:enterEmailAddress];
    
    createAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(85, 610, 150, 30)];
    createAccountButton.backgroundColor = [UIColor blueColor];
    createAccountButton.layer.cornerRadius = 10;
    [createAccountButton setTitle:@"Sign Up" forState:UIControlStateNormal];

    [signUpForm addSubview:createAccountButton];

    
    
        [UIView animateWithDuration:0.1 animations:^{
      signUpForm.frame = CGRectMake(0, -300, 320, 1000);
    }];

}



//remove auto Caps, animate login fields up if you are not already.

-(void)backToSignInOrUp
{
    
    
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
         
         
         UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
         activityIndicator.color= [UIColor redColor];
         activityIndicator.frame = CGRectMake(0, 10, 100, 50);
         
         [activityIndicator startAnimating];
         
         
         
         //[UIActivityIndicatorView
         // start...
         // addSubview
         // run method
         
         
         
         [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
             
             if (error == nil)
             {
    
                 self.navigationController.navigationBarHidden = NO;
                 self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
             }
             else
             {
                 
                 NSString * errorDescription = error.userInfo[@"error"];
                 
                 UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:errorDescription delegate:@"Try Again" cancelButtonTitle:@"ALERT" otherButtonTitles:nil, nil];
                 
                 
                 [alertView show];
                 
                 //error.userInfo[@"error"]
                 //UIAlertView with message
                 
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
