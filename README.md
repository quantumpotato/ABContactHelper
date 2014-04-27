ABContactHelper
===============

Feel free to submit pull requests to improve in any way.

Objective-C Address Book wrapper. Provides functionality to create/update/delete contacts from the device address book.

```objective-c
#import "ABContactsHelper.h"

ABContact *newContact = [[ABContact alloc] init];
newContact.firstname = @"Jim";
newContact.lastname = @"Thompson";
newContact.image = [UIImage imageNamed:@"thompson.png"];
[newContact addEmailItem:@"j.thompson@company.com" withLabel:kABWorkLabel];
[newContact addPhoneItem:@"1(415)123-5555" withLabel:kABPersonPhoneMobileLabel];

NSError *error;
if (![ABStandin save:&error]) {
    NSLog(@"Error: %@", [error localizedDescription]);
}

```

### Demo App 

Contains a demo app which shows listing, adding, and removing contacts from the device address book.

![Screenshot](https://raw.github.com/shepting/ABContactHelper/clearer_code_layout/Demo/Address-Book-Demo-App.png)
