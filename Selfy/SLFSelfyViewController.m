//
//  SLFSelfyViewController.m
//  Selfy
//
//  Created by Austin Nolan on 4/22/14.
//  Copyright (c) 2014 Austin Nolan. All rights reserved.
//

#import "SLFSelfyViewController.h"

#import <Parse/Parse.h>

@interface SLFSelfyViewController () <UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

{
    UITextView * captionField;
    
    UIButton * submitSelfy;
    
    UIView * newForm;
    
    UIImageView * selfyFrame;
    
    //UIImageView * imageView;
    
    UIBarButtonItem * libraryButton;
    
    UIImagePickerController * photoLibrary;
}

@property (nonatomic) UIImage * originalImage;

@end

@implementation SLFSelfyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        UIImageView * braves = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 20, 20)];
//        braves.image = [UIImage imageNamed:@"Braves"];
//        [self.contentView addSubview:popeye];
//        self.view.backgroundColor = [UIColor whiteColor];
//        Custom initialization
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


-(void)setOriginalImage:(UIImage *)originalImage
{
    _originalImage = originalImage;
    //filterVC.imageToFilter = originalImage;
    selfyFrame.image = originalImage;
}


- (void)viewWillLayoutSubviews
{
    [super viewDidLoad];
    
    UIBarButtonItem * cancelNewSelfyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelNewSelfy)];
    
    cancelNewSelfyButton.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = cancelNewSelfyButton;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
    [self.view addGestureRecognizer:tap];
    
//    imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:imageView];
    
    libraryButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(choosePhoto)];
                                       
    libraryButton.tintColor= [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem = libraryButton;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
//   Do any additional setup after loading the view.
}


-(void)createNewForm
{
    selfyFrame = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 150, 150)];
    selfyFrame.backgroundColor = [UIColor blueColor];
    
//  selfyFrame.image = [UIImage imageNamed:@"Braves2"];
    
    newForm = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 280, self.view.frame.size.height - 40)];
    
//    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 180, 280, 280)];
//    imageView.backgroundColor = [UIColor greenColor];
    
    [newForm addSubview:selfyFrame];
    [self.view addSubview:newForm];

    captionField = [[UITextView alloc] initWithFrame:CGRectMake(20, 250, 300, 150)];
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


-(void)choosePhoto
{
    NSLog(@"press");
    
    photoLibrary = [[UIImagePickerController alloc] init];
    
    photoLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    photoLibrary.allowsEditing = YES;
    photoLibrary.delegate = self;

    [self presentViewController:photoLibrary animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];

 }


-(void)cancelNewSelfy
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)viewDidLayoutSubviews
{
    NSLog(@"load subviews");
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
//    connect current user to newsSelfy as parent : Parse "relational data"
//    UIImage * image = [UIImage imageNamed:@"Braves2"];
    
    NSData * imageData = UIImagePNGRepresentation(selfyFrame.image);
    
    PFFile * imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    
    PFObject * newSelfy = [PFObject objectWithClassName:@"UserSelfy"];
    
    newSelfy[@"caption"] = captionField.text;
    newSelfy[@"image"] = imageFile;
    
    newSelfy[@"parent"]= [PFUser currentUser];
    
    [newSelfy saveInBackground];
    
    [newSelfy saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"%hhd",succeeded);
        
        [self cancelNewSelfy];
    }];
    
    //NSDictionary * newSelfy = [[NSDictionary alloc] init];
    //newSelfy[@"caption"] = captionField.text;
    //[self.delegate addNewSelfy:newSelfy];
    //NewPFObject classs name "UserSelfy"
    //put a png file inside app
    //PFFile
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
