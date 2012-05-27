//  Created by Sir Cheshire

#import <UIKit/UIKit.h>

@interface Login : UIViewController {
    UITextField *senha;
    BOOL exitB;
    UILabel *labelPass;
}

@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic, strong) IBOutlet UITextField *senha;
- (IBAction)check:(id)sender;
- (IBAction)start:(id)sender;
@property (nonatomic, strong) IBOutlet UILabel *labelPass;

@end
