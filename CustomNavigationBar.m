//  Created by Sir Cheshire

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect 
{
    // ColorSync manipulated image
    NSString* bgName;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
    {
        bgName = @"NavigationBarIpad.png";
    }
    else
    {
        bgName = @"NavigationBar.png";
    }
    
    UIImage *imageBackground = [UIImage imageNamed: bgName];
    [imageBackground drawInRect: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
}

@end
