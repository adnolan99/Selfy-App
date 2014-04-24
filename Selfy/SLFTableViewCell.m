//
//  SLFTableViewCell.m
//  Selfy
//
//  Created by Austin Nolan on 4/21/14.
//  Copyright (c) 2014 Austin Nolan. All rights reserved.
//

#import "SLFTableViewCell.h"

@implementation SLFTableViewCell

{
    UILabel * userId;
    UILabel * caption;
    UIImageView * userAvatar;
    UIImageView * otherImage;
    
    
    
}




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        
        userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 275, 40, 40)];
        userAvatar.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:userAvatar];
        
        otherImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 240, 240)];
        otherImage.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:otherImage];
        
        userId = [[UILabel alloc] initWithFrame:(CGRectMake(80, 270, 100, 30))];
        userId.textColor = [UIColor darkGrayColor];
        userId.font = [UIFont systemFontOfSize:22];
        [self.contentView addSubview:userId];
        
        
        caption = [[UILabel alloc] initWithFrame:CGRectMake(80, 285, 220, 40)];
        caption.textColor = [UIColor blackColor];
        caption.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:caption];
        
        
        
        
        //otherImage


    }
    return self;
}


-(void)setProfile:(NSDictionary *)profile
{
    //NSString *imageURLString = profile[@"avatar"];
    
    NSURL * imageUrl = [NSURL URLWithString:profile[@"avatar"]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage * image = [UIImage imageWithData:imageData];
    userAvatar.image = image;
    
    
    NSURL * imageUrl2 = [NSURL URLWithString:profile[@"image"]];
    NSData * imageData2 = [NSData dataWithContentsOfURL:imageUrl2];
    UIImage * image2 = [UIImage imageWithData:imageData2];
    otherImage.image = image2;
    
    
    userId.text = profile[@"USER_ID"];
    caption.text = profile[@"caption"];
    //userAvatar.image = [UIImage imageWithData:profile[@"avatar"]];
    
    _profile = profile;
}





- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
