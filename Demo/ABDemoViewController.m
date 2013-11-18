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
@property (nonatomic, strong) UIAlertView *removeAlert;
@property (nonatomic, strong) UIAlertView *addAlert;
@property (nonatomic, strong) ABContact *contactToRemove;
@property (nonatomic, strong) ABContact *contactToAdd;

@end

@implementation ABDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contacts = [ABContactsHelper contacts];
        
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addBarButton;
    
    UIBarButtonItem *removeBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Remove" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    self.navigationItem.leftBarButtonItem = removeBarButton;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ABContactCell"];
    cell.textLabel.text = [_contacts[indexPath.row] compositeName];
    return cell;
}


#pragma mark NEW PERSON DELEGATE METHODS
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
	if (person)
	{
		ABContact *contact = [ABContact contactWithRecord:person];
		self.title = [NSString stringWithFormat:@"Added %@", contact.compositeName];
        
        NSError *error;
		BOOL success = [ABContactsHelper addContact:contact withError:&error];
        if (!success)
        {
            NSLog(@"Could not add contact. %@", error.localizedFailureReason);
            self.title = @"Error.";
		}
        
        [ABStandin save:nil];
	}
	else
		self.title = @"Cancelled";
    
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark PEOPLE PICKER DELEGATE METHODS
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:YES];
	ABContact *contact = [ABContact contactWithRecord:person];
    self.contactToRemove = contact;
    
    NSString *query = [NSString stringWithFormat:@"Really delete %@?",  contact.compositeName];
    
    self.removeAlert = [[UIAlertView alloc] initWithTitle:query message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [self.removeAlert show];
    
	return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.removeAlert) {
        if (buttonIndex == OK_INDEX) {
            self.title = @"Deleted Contact";
            [self.contactToRemove removeSelfFromAddressBook:nil];
            [ABStandin save:nil];
        }
    }
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	// required method that is never called in the people-only-picking
	[self dismissModalViewControllerAnimated:YES];
	return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) add
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

- (void)remove
{
	ABPeoplePickerNavigationController *ppnc = [[ABPeoplePickerNavigationController alloc] init];
	ppnc.peoplePickerDelegate = self;
	[self presentModalViewController:ppnc animated:YES];
}


@end
