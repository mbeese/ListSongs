//
//  DetailViewController.h
//  ListSongs
//
//  Created by Michael Beese on 2/18/15.
//  Copyright (c) 2015 MTZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSString *songName;
@property (strong, nonatomic) NSString *albumName;
@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *releaseDate;
@property (strong, nonatomic) NSString *artworkURL;
@property (strong, nonatomic) AVPlayer *audioPlayer;
@property (strong, nonatomic) NSString *audioPreviewURL;

@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *artwork;

@end

