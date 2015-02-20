//
//  MTZSongTableViewCell.h
//  ListSongs
//
//  Created by Michael Beese on 2/19/15.
//  Copyright (c) 2015 MTZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTZSongTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *artistName;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@end
