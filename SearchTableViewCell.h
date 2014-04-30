//
//  SearchTableViewCell.h
//  AddressBookExample
//
//  Created by alexander on 4/25/14.
//  Copyright (c) 2014 Uriphium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell
@property (nonatomic)BOOL added;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end
