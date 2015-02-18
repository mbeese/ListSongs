//
//  DetailViewController.h
//  ListSongs
//
//  Created by Michael Beese on 2/18/15.
//  Copyright (c) 2015 MTZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

