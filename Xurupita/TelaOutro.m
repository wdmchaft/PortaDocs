//  Created by Sir Cheshire

#import "TelaOutro.h"
#import "LogicCore.h"

@implementation TelaOutro
@synthesize navItem;
@synthesize nome;
@synthesize botRet;
@synthesize label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL) textFieldShouldReturn:(UITextField*) textField {
    [textField resignFirstResponder]; 
    return YES;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundPattern.png"]]];
    
#ifdef ENG
    [navItem setTitle:@"Insert a Name"];
    [botRet setTitle:@"Return" forState:UIControlStateNormal];
    [label setText:@"Document's Name"];
#endif
    
    UILabel *labelT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [labelT setTextAlignment:UITextAlignmentCenter];
	[labelT setFont:[UIFont boldSystemFontOfSize:16.0]];
	[labelT setBackgroundColor:[UIColor clearColor]];
	[labelT setTextColor:[UIColor colorWithRed:57.0/255.0 green:54.0/255.0 blue:40.0/255.0 alpha:1.0]];
    
	[labelT setText:navItem.title];
	[navItem setTitleView:labelT];
    
    core = [[LogicCore alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setNome:nil];
    [self setLabel:nil];
    [self setNavItem:nil];
    [self setBotRet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}


-(NSString*) checkWhite:(NSString*) check
{
    NSString * ret = check;
    
    //remover whitespace do inicio e do fim
    /*if ([ret characterAtIndex:0] == ) 
    {
     
    }*/
    
    return ret;
}

- (IBAction)send:(id)sender 
{
    [nome setText:[self checkWhite:nome.text]];
    
    if ([nome.text isEqualToString:@"cheshire"] || [nome.text isEqualToString:@"Cheshire"]) 
    {
        
        UIAlertView *alert = 
        [[UIAlertView alloc] initWithTitle:@"The proper order of things is often a mystery to me." message: @"You, too?" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [alert show];
        
    }
    
    if ([core insertDoc:nome.text]) 
    {
        //chamaria o avo
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alert = 
        [[UIAlertView alloc] initWithTitle:@"Erro" message: @"Item já existe" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [alert show];
        
    }
}

- (IBAction)retornar:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
