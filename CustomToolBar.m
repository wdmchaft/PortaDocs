//  Created by Sir Cheshire

#import "CustomToolBar.h"

@implementation CustomToolbar

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) 
    {
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
      bgName = @"ToolBarIpad.png";
    }
    else
    {
        bgName = @"ToolBar.png";
    }
    
    UIImage *imageBackground = [UIImage imageNamed: bgName];
    [imageBackground drawInRect: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end