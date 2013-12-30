//
//  ABDemoViewController.m
//  HelloWorld
//
//  Created by Steven Hepting on 11/18/13.
//
//

#import "ABDemoViewController.h"
#import "ABStandin.h"

#define COOKBOOK_PURPLE_COLOR [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define IS_IPAD    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define OK_INDEX 1
#define CANCEL_INDEX 0

@interface ABDemoViewController ()
@property (nonatomic, assign) BOOL loaded;
@end

@implementation ABDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addBarButton;
    
    UIBarButtonItem *removeBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Remove" style:UIBarButtonItemStylePlain target:self action:@selector(removeSelectedContact)];
    self.navigationItem.leftBarButtonItem = removeBarButton;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ContactCell"];
    
    self.title = @"Contacts";
}

- (void)viewDidAppear:(BOOL)animated
{
    self.loaded = YES;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.loaded) {
        // This causes a contact access request. If it happens too early (say, part
        // of applicationDidFinishLaunchingWithOptions) the app locks that first run.
        return [ABContactsHelper contactsCount];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ABContact *contact = [ABContactsHelper contacts][indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    
    cell.textLabel.text = [contact compositeName];
    
    return cell;
}


#pragma mark NEW PERSON DELEGATE METHODS
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
	if (person)
	{
		ABContact *contact = [ABContact contactWithRecord:person];
        
        
        NSError *error;
		BOOL success = [ABContactsHelper addContact:contact withError:&error];
        if (!success) {
            NSLog(@"Could not add contact. %@", error.localizedFailureReason);
		}
        
        NSLog(@"Added %@", [contact compositeName]);
        [ABStandin save:nil];
        
        [self.tableView reloadData];
	} else {
        NSLog(@"Cancelled");
    }
    
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)add
{
	// create a new view controller
	ABNewPersonViewController *npvc = [[ABNewPersonViewController alloc] init];
	
	// Create a new contact
	ABContact *contact = [ABContact contact];
	npvc.displayedPerson = contact.record;
	
	// Set delegate
	npvc.newPersonViewDelegate = self;
	
	[self.navigationController pushViewController:npvc animated:YES];
}

- (void)removeSelectedContact
{
    NSUInteger row = [self.tableView indexPathForSelectedRow].row;
    ABContact *contact = [ABContactsHelper contacts][row];
    
    NSError *error;
    if (![contact removeSelfFromAddressBook:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    };
    [ABStandin save:nil];
    
    [self.tableView reloadData];
}


@end
