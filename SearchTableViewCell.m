//
//  SearchTableViewCell.m
//  AddressBookExample
//
//  Created by alexander on 4/25/14.
//  Copyright (c) 2014 Uriphium. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib
{
    // Initialization code
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
