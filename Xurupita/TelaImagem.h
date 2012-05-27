//  Created by Sir Cheshire

#import <UIKit/UIKit.h>

@interface TelaImagem : UIViewController <UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>
{
    UIImageView *imageView;
    UIScrollView *scrollView;
    UINavigationItem *naviTitulo;
    
    
    NSString* titulo;
    
    BOOL isFront;
    UIBarButtonItem *botRet;
    UIBarButtonItem *defButton;
    
    BOOL selecting;
    
    UIPopoverController* popper;
}

@property (nonatomic, strong) IBOutlet UIBarButtonItem *defButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *botRet;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UINavigationItem *naviTitulo;
@property (strong) UIPopoverController* popper;
- (IBAction)retornar:(id)sender;
- (IBAction)setImagem:(id)sender;

-(id) initWithNome: (NSString*) name isFront:(BOOL) isF;

@end
