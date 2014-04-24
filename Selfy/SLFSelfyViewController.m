//
//  SLFSelfyViewController.m
//  Selfy
//
//  Created by Austin Nolan on 4/22/14.
//  Copyright (c) 2014 Austin Nolan. All rights reserved.
//

#import "SLFSelfyViewController.h"

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
    
    
    newForm = [[UIView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:newForm];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    imageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
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
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}


-(void)tapScreen
{
    
    [captionField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = self.view.frame;

    }];
}


-(void)submitYourSelfy
{
    
    NSDictionary * newSelfy = [[NSDictionary alloc] init];
    
   //newSelfy[@"caption"] = captionField.text;
    
    [self.delegate addNewSelfy:newSelfy];
    
    
    
    
    
    
    
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
