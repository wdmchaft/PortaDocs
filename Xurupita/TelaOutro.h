//  Created by Sir Cheshire

#import <UIKit/UIKit.h>

@class LogicCore;
@interface TelaOutro : UIViewController <UITextFieldDelegate> 
{
    UITextField *nome;
    UILabel *label;
    
    LogicCore* core;
    UINavigationItem *navItem;
}

@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;
@property (nonatomic, strong) IBOutlet UITextField *nome;
@property (strong, nonatomic) IBOutlet UIButton *botRet;

@property (nonatomic, strong) IBOutlet UILabel *label;
- (IBAction)send:(id)sender;
- (IBAction)retornar:(id)sender;

@end
