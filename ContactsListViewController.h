//
//  MasterViewController.h
//  AddressBookExample
//
//  Created by alexander on 4/24/14.
//  Copyright (c) 2014 Uriphium. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddContactsBlock)(NSArray *addedPerson);


@interface ContactsListViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic,copy)AddContactsBlock addPersonBlock;

@end
