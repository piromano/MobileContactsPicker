//
//  MasterViewController.m
//  AddressBookExample
//
//  Created by alexander on 4/24/14.
//  Copyright (c) 2014 Uriphium. All rights reserved.
//

#import "ContactsListViewController.h"
#import "ContactTableViewCell.h"
#import "SearchTableViewCell.h"
#import "AddressBook.h"

@interface ContactsListViewController () {
    RHAddressBook *_addressBook;
    __weak IBOutlet UISearchBar *searchbar;
    
    NSMutableArray *_addedPerson;
    
    NSArray *_allPeople;
}

@property (nonatomic) NSArray *searchResults;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic) NSMutableArray *sections;

@end

@implementation ContactsListViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}
- (IBAction)done:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    if (_addPersonBlock!=nil) {
        _addPersonBlock([_addedPerson copy]);
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ContactTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    if (!self.doneButton) {
       self.doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        
        self.navigationItem.rightBarButtonItem = _doneButton;
    }

    
    _addedPerson = [NSMutableArray array];
    
    _addressBook = [[RHAddressBook alloc] init];
    
     _allPeople = [_addressBook people];
    
    [self setObjects:_allPeople];

    
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchCell"];
}



- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{

    _searchResults = [_allPeople filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.name CONTAINS[cd] %@",searchString]];
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView{
    _searchResults = nil;
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return 1;
    }
	else
	{
        return _sections.count;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return _searchResults.count;
    }
	else
	{
        return [_sections[section] count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *returnCell;
    
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
        
        RHPerson *person =  _searchResults[indexPath.row];
        
        cell.added = [_addedPerson containsObject:person];
        
        cell.nameLabel.text = [person name];
        
        returnCell = cell;
    }else{
        ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
        RHPerson *person =  _sections[indexPath.section][indexPath.row];
        
        cell.added = [_addedPerson containsObject:person];
        
        cell.nameLabel.text = [person name];
        
        returnCell = cell;
    }

    
    return returnCell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    RHPerson *person;
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        
        person =  _searchResults[indexPath.row];
        
        [self.searchDisplayController setActive:NO animated:YES];

    }else{
        person =  _sections[indexPath.section][indexPath.row];
    }
    
    
    ContactTableViewCell *cell = (ContactTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    
    
    BOOL added = [_addedPerson containsObject:person];
    
    if (added) {
        
        [_addedPerson removeObject:person];
        
    }else{
        
        [_addedPerson addObject:person];
    }
    
    cell.added = !added;
    
    
    if (_addedPerson.count>0&&self.navigationItem.rightBarButtonItem==nil) {
        
        [self.navigationItem setRightBarButtonItem:self.doneButton];
        
    }else if (_addedPerson.count==0&&self.navigationItem.rightBarButtonItem!=nil){
        
        [self.navigationItem setRightBarButtonItem:nil];
    }
    
    
}



- (void)setObjects:(NSArray *)objects {

    NSInteger  sectionTitlesCount = [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
    
    NSMutableArray *mutableSections = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    for (NSUInteger idx = 0; idx < sectionTitlesCount; idx++) {
        
        [mutableSections addObject:[NSMutableArray array]];
    }
    
    for (id object in objects) {
        
        NSInteger sectionNumber = [[UILocalizedIndexedCollation currentCollation] sectionForObject:object collationStringSelector:@selector(lastName)];
        
        [[mutableSections objectAtIndex:sectionNumber] addObject:object];
    }
    
    for (NSUInteger idx = 0; idx < sectionTitlesCount; idx++) {
        
        NSArray *objectsForSection = [mutableSections objectAtIndex:idx];
        
        [mutableSections replaceObjectAtIndex:idx withObject:[[UILocalizedIndexedCollation currentCollation] sortedArrayFromArray:objectsForSection collationStringSelector:@selector(lastName)]];
    }
    
    self.sections = mutableSections;
    
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.searchDisplayController.searchResultsTableView!=tableView) {
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.searchDisplayController.searchResultsTableView!=tableView) {
        return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (self.searchDisplayController.searchResultsTableView!=tableView) {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
    }
    return 0;
}
@end
