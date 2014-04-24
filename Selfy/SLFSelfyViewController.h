//
//  SLFSelfyViewController.h
//  Selfy
//
//  Created by Austin Nolan on 4/22/14.
//  Copyright (c) 2014 Austin Nolan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLFTableViewCell.h"



@protocol SLFSelfyViewControllerDelegate;

@interface SLFSelfyViewController : UIViewController
@property (nonatomic,assign) id<SLFSelfyViewControllerDelegate> delegate;
@end


@protocol SLFSelfyViewControllerDelegate <NSObject>
-(void)addNewSelfy: (NSDictionary *)newSelfy;
@end