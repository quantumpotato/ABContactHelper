//
//  ABDemoViewController.h
//  HelloWorld
//
//  Created by Steven Hepting on 11/18/13.
//
//

#import <UIKit/UIKit.h>
#import "ABContactsHelper.h"

@interface ABDemoViewController : UITableViewController <ABNewPersonViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSArray *contacts;

@end
