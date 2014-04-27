//
//  SLFSelfyViewController.m
//  Selfy
//
//  Created by Austin Nolan on 4/22/14.
//  Copyright (c) 2014 Austin Nolan. All rights reserved.
//

#import "SLFSelfyViewController.h"

#import <Parse/Parse.h>


@interface SLFSelfyViewController () <UITextViewDelegate>

{
    UITextView * captionField;
    
    UIButton * submitSelfy;
    
    UIView * newForm;
    
}



@end

@implementation SLFSelfyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIImageView * popeye = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 20, 20)];
        
        
        popeye.image = [UIImage imageNamed:@"popeye"];
        
        //[self.contentView addSubview:popeye];
        
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        
        
        // Custom initialization
    }
    return self;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.4 animations:^{
        newForm.frame = CGRectMake(0, -150, 320, self.view.frame.size.height);
    }];
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem * cancelNewSelfyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelNewSelfy)];
    
    cancelNewSelfyButton.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = cancelNewSelfyButton;
    
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}


-(void)createNewForm
{
    newForm = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, self.view.frame.size.height - 40)];
    
    [self.view addSubview:newForm];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 280, 280)];
    imageView.backgroundColor = [UIColor greenColor];
    [newForm addSubview:imageView];
    
    
    captionField = [[UITextView alloc] initWithFrame:CGRectMake(10, 250, 300, 150)];
    captionField.backgroundColor = [UIColor redColor];
    captionField.layer.cornerRadius = 10;
    captionField.keyboardType = UIKeyboardTypeTwitter;
    captionField.textColor = [UIColor blackColor];
    
    
    [newForm addSubview:captionField];
    captionField.delegate = self;
    
    
    submitSelfy = [[UIButton alloc] initWithFrame:CGRectMake(85, 200, 150, 40)];
    submitSelfy.backgroundColor = [UIColor redColor];
    submitSelfy.layer.cornerRadius = 20;
    [submitSelfy setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submitSelfy setTitle:@"Take a Selfy!" forState:UIControlStateNormal];
    [submitSelfy addTarget:self action:@selector(submitYourSelfy) forControlEvents:UIControlEventTouchUpInside];
    [newForm addSubview:submitSelfy];
    
}


-(void)cancelNewSelfy
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.view);
    [self createNewForm];
    
}



-(void)tapScreen
{
    
    [captionField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(20, 20, 280, self.view.frame.size.height - 40);

    }];
}


-(void)submitYourSelfy
{
    
    
    UIImage * image = [UIImage imageNamed:@"popeye"];
    
    NSData * imageData = UIImagePNGRepresentation(image);
    
    PFFile * imageFile = [PFFile fileWithName:@"Popeye Pic" data:imageData];
    
    PFObject * newSelfy = [PFObject objectWithClassName:@"UserSelfy"];
    
    newSelfy[@"caption"] = captionField.text;
    newSelfy[@"image"] = imageFile;
    
    [newSelfy saveInBackground];
    
    
    
    //NSDictionary * newSelfy = [[NSDictionary alloc] init];
    
   //newSelfy[@"caption"] = captionField.text;
    
    //[self.delegate addNewSelfy:newSelfy];
    
    
    //NewPFObject classs name "UserSelfy"
    //put a png file inside app
    //PFFile
    
    //
    
    
    
    
    
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
