//
//  ContactTableViewCell.h
//  AddressBookExample
//
//  Created by alexander on 4/24/14.
//  Copyright (c) 2014 Uriphium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic)BOOL added;
@end
