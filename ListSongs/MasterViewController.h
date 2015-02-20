//
//  MasterViewController.h
//  ListSongs
//
//  Created by Michael Beese on 2/18/15.
//  Copyright (c) 2015 MTZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController<UITextFieldDelegate>
@property (strong, nonatomic) DetailViewController *detailViewController;

- (void) updateSongList:(NSString *)searchString;
@property (strong, nonatomic) NSArray *songs;
@property (weak, nonatomic) IBOutlet UITextField *searchField;


@end

