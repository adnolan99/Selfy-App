//
//  SLFSignUpViewController.m
//  Selfy
//
//  Created by Austin Nolan on 4/29/14.
//  Copyright (c) 2014 Austin Nolan. All rights reserved.
//

#import "SLFSignUpViewController.h"

#import <Parse/Parse.h>

# import "SLFTableViewController.h"

@interface SLFSignUpViewController ()<UITextFieldDelegate>

@end

@implementation SLFSignUpViewController

{
    
    
    UIView * signupForm;
//    UITextField * usernameField;
//    UITextField * displayNameField;
//    UITextField * passwordField;
//    UITextField * emailField;
    UIButton * signUpButton;
    UIImageView * avatar;
    NSArray * fieldsNames;
    
    NSMutableArray * fields;
    
    float signupOrigY;
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    UIBarButtonItem * cancelSignUpButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelsignUpButton)];
    
    
    cancelSignUpButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelSignUpButton;
    
    signupOrigY = (self.view.frame.size.height -240) /2;
    
    signupForm = [[UIView alloc]initWithFrame:CGRectMake(20, signupOrigY, 280, 240)];
    
    [self.view addSubview:signupForm];
    
    fieldsNames = @[@"Create Username",
             @"Create Password",
             @"Create Display Name",
             @"Enter Email"];
    
    fields = [@[] mutableCopy];
    
    for (NSString * name in fieldsNames)
       
    {
        NSInteger index = [fieldsNames indexOfObject:name];
        
        
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, (index * 50), 280, 40)];
        
        textField.backgroundColor = [UIColor orangeColor];
        textField.layer.cornerRadius = 10;
        textField.placeholder = name;
        textField.tintColor = [UIColor orangeColor];
        textField.delegate = self;
        
        
        [textField resignFirstResponder];
        
        [fields addObject:textField];
        
        
        [signupForm addSubview:textField];
        
        signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 340, 280, 40)];
        signUpButton.backgroundColor = [UIColor greenColor];
        [signUpButton addTarget:self action:@selector(signup) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:signUpButton];
    }
    
//    usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
//    usernameField.backgroundColor = [UIColor colorWithWhite:0.1 alpha:.05];
//    usernameField.layer.cornerRadius = 10;
//    usernameField.placeholder = @"Create Username";
//    usernameField.tintColor = [UIColor orangeColor];
//    [usernameField resignFirstResponder];
//    [self.view addSubview:usernameField];
//    
//    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, 280, 40)];
//    passwordField.backgroundColor = [UIColor colorWithWhite:0.1 alpha:.05];
//    passwordField.layer.cornerRadius = 10;
//    passwordField.secureTextEntry =YES;
//    passwordField.placeholder = @"Create Password";
//    passwordField.tintColor = [UIColor orangeColor];
//    [self.view addSubview:passwordField];
//    
//
//    emailField = [[UITextField alloc] initWithFrame:CGRectMake(20, 90, 100, 20)];
//    emailField.backgroundColor = [UIColor colorWithWhite:0.1 alpha:.05];
//    emailField.layer.cornerRadius = 10;
//    emailField.secureTextEntry =YES;
//    emailField.placeholder = @"Enter Email";
//    emailField.tintColor = [UIColor orangeColor];
//    [self.view addSubview:emailField];
//    
//    displayNameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 90, 100, 20)];
//    displayNameField.backgroundColor = [UIColor colorWithWhite:0.1 alpha:.05];
//    displayNameField.layer.cornerRadius = 10;
//    displayNameField.secureTextEntry =YES;
//    displayNameField.placeholder = @"Create Display Name";
//    displayNameField.tintColor = [UIColor orangeColor];
//    [self.view addSubview:displayNameField];
    

}


-(void)signup
{
  
    PFUser * user = [PFUser user];
    
    UIImage * avatarImage = [UIImage imageNamed:@"Braves"];
    
    NSData * imageData = UIImagePNGRepresentation(avatarImage);
    
    
    //NSData * imageData = UIImagePNGRepresentation(avatar.image);
    
    PFFile * imageFile = [PFFile fileWithName:@"avatar.png" data:imageData];
    
    user.username = ((UITextField *)fields [0]).text;
    user.password = ((UITextField *)fields [1]).text;
    user.email = ((UITextField *)fields [3]).text;
    user[@"createDisplay"] = ((UITextField *)fields [2]).text;
    user[@"avatar"] = imageFile;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error == nil)
        {
            UINavigationController * pnc = (UINavigationController *)self.presentingViewController;
            
            pnc.navigationBarHidden = NO;
            pnc.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
            
            
            
            
            [self cancelSignUp];
            
            
        }
        else
        {
            
            NSString * errorDescription = error.userInfo[@"error"];
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"UsernameTaken" message:errorDescription delegate:self cancelButtonTitle:@"Try Another Username" otherButtonTitles:nil];
            
            [alertView show];
            
            
            
        }
    }];
    
}


-(void)cancelSignUp
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
        
        self.view.backgroundColor = [UIColor purpleColor];
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        [self.view addGestureRecognizer:tap];
        
        // Custom initialization
    }
    return self;
}

-(void)hideKeyboard
{
    for (UITextField * textFieldItem in fields)
    {
        [textFieldItem resignFirstResponder];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        signupForm.frame = CGRectMake(20, signupOrigY - 50, 280, 240);
    }];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

     
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    
//    NSInteger index = [fields indexOfObject:textField];
//    NSInteger emptyIndex = [fields count];
//    
//    for (UITextField * textFieldItem in fields)
//    {
//        NSInteger fieldIndex = [fields indexOfObject:textFieldItem];
//        if(emptyIndex == [fields count])
//        {
//            if([textFieldItem.text isEqualToString:@""])
//            {
//                emptyIndex = fieldIndex;
//            }
//        }
//    }
//    
//    
//    
//    if(index <= emptyIndex) return YES;
//    return NO;
//}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    NSInteger index = [fields indexOfObject:textField];
    
    int extraSlide = index * 15 +75;
    
    NSLog(@"%.00f",self.view.frame.size.height);
    
    if(self.view.frame.size.height > 500)
    {
        int extraSlide = 107;
    }
    else {
        NSInteger index = [fields indexOfObject:textField];
        extraSlide = index * 25 + 65;
    }
    

    

    
    
    
    
    
    [UIView animateWithDuration:0.2 animations:^{
             signupForm.frame = CGRectMake(20, signupOrigY -extraSlide, 280, 240);
           }];
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
