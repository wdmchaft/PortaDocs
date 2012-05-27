//  Created by Sir Cheshire

#import <UIKit/UIKit.h>

@interface CreatePass : UIViewController 
{
    UITextField *senhaUm;
    UITextField *senhaDois;
    UILabel *labelOld;
    UITextField *senhaOld;
    UISwitch *purgeButton;
    UIButton *okButton;
    UINavigationItem *navItem;
    UIButton *recButton;
    UIButton *aceitButton;
    UITextView *contrato;
    UIButton *aceitar;
}

@property (nonatomic, strong) IBOutlet UITextField *senhaOld;
@property (nonatomic, strong) IBOutlet UITextField *senhaUm;
@property (nonatomic, strong) IBOutlet UITextField *senhaDois;
@property (nonatomic, strong) IBOutlet UILabel *labelOld;
@property (nonatomic, strong) IBOutlet UISwitch *purgeButton;
@property (nonatomic, strong) IBOutlet UIButton *okButton;
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;
@property (nonatomic, strong) IBOutlet UIButton *recButton;
@property (nonatomic, strong) IBOutlet UIButton *aceitButton;
@property (nonatomic, strong) IBOutlet UITextView *contrato;
@property (strong, nonatomic) IBOutlet UIButton *botRet;
@property (strong, nonatomic) IBOutlet UILabel *labelPassOne;
@property (strong, nonatomic) IBOutlet UILabel *labelPassTwo;

- (IBAction)check:(id)sender;
- (IBAction)checkDois:(id)sender;
- (IBAction)create:(id)sender;
- (IBAction)retornar:(id)sender;
- (IBAction)checkPurge:(id)sender;
- (IBAction)infoPurge:(id)sender;
- (IBAction)recusar:(id)sender;
- (IBAction)aceitar:(id)sender;




@end
