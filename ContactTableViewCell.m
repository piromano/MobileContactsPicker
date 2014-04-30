//
//  ContactTableViewCell.m
//  AddressBookExample
//
//  Created by alexander on 4/24/14.
//  Copyright (c) 2014 Uriphium. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    self.statusLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAdded:(BOOL)added{
    _added = added;
    
    if (_added) {
        self.statusLabel.text =@"Added";
    }else{
        self.statusLabel.text =@"";
    }
}

@end
