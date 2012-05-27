//  Created by Sir Cheshire

#import "Login.h"
#import "XurupitaViewController.h"
#import "LogicCore.h"
#import "CreatePass.h"

@implementation Login
@synthesize labelPass;
@synthesize navItem;
@synthesize senha;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        exitB = NO;
    }
    return self;
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
    
#ifdef ENG
    [labelPass setText:@"Insert your Password"];
#endif
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [label setTextAlignment:UITextAlignmentCenter];
	[label setFont:[UIFont boldSystemFontOfSize:16.0]];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor colorWithRed:57.0/255.0 green:54.0/255.0 blue:40.0/255.0 alpha:1.0]];
    
	[label setText:navItem.title];
	[navItem setTitleView:label];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundPattern.png"]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSenha:nil];
    [self setLabelPass:nil];
    [self setNavItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}

-(void) start
{
    LogicCore* temp = [[LogicCore alloc] init];
    
    
    
    if (![LogicCore loadGreed]) 
    {
#ifdef PT
        [temp insertDoc:@"Visa"];
        [temp insertDoc:@"Identidade"];
        [temp insertDoc:@"Passaporte"];
#endif
        
#ifdef ENG
        [temp insertDoc:@"ID"];
        [temp insertDoc:@"Visa"];
        [temp insertDoc:@"Passport"];
#endif
        
        [temp update:NO];
        
        CreatePass* create = [[CreatePass alloc] init];
        
        [create setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        
        [self presentModalViewController:create animated:YES];
        
    }
    else
    {
        if (![LogicCore isUpdated]) 
        {
            
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            
            // Point to Document directory
            NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            
            // Write out the contents of home directory to console
            NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil]);
            [temp update:YES];
            
           
            NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil]);
        }
        
        if ([LogicCore loadPass] == nil || [[LogicCore loadPass] isEqualToString:@""]) 
        {
            XurupitaViewController* mainView = [[XurupitaViewController alloc] init];
            [mainView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
            
            [self presentModalViewController:mainView animated:YES];
        }
    }
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //[self start];
    
    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(start) userInfo:nil repeats:NO];
    
}

- (IBAction)check:(id)sender 
{
    if ([senha.text length] == 4) 
    {
        if ([senha.text isEqualToString:[LogicCore loadPass]]) 
        {
            
            [LogicCore clearTry];
            //[self dismissModalViewControllerAnimated:YES];
            XurupitaViewController* mainView = [[XurupitaViewController alloc] init];
            [mainView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
            
            [self presentModalViewController:mainView animated:YES];
        }
        else
        {
            LogicCore* core = [[LogicCore alloc] init];
            if ([core loadPurge]) 
            {
                
                if ([LogicCore saveTry]) 
                {
#ifdef PT
                    UIAlertView *alert = 
                    [[UIAlertView alloc] initWithTitle:@"Auto Purge." message:@"Limite de tentativas ultrapassado. Dados do aplicativo serão deletados e o aplicativo fechado." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
                    [alert show];
                    
#endif
                    
#ifdef ENG
                    UIAlertView *alert = 
                    [[UIAlertView alloc] initWithTitle:@"Auto Purge." message:@"Failed login attempts limit reached. App will now restart and erase all its saved data." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
                    [alert show];
                    
#endif
                    
                    LogicCore* temp = [[LogicCore alloc] init];
                    
                    [temp purge];
                    
                    exitB = YES;
                }
                else
                {
#ifdef PT
                    UIAlertView *alert = 
                    [[UIAlertView alloc] initWithTitle:@"Erro." message: [NSString stringWithFormat:@"Senha incorreta. \n Tentativas restantes: %d.",10-[LogicCore loadTry]] delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
                    [alert show];
                    
#endif
                    
#ifdef ENG
                    UIAlertView *alert = 
                    [[UIAlertView alloc] initWithTitle:@"Error." message: [NSString stringWithFormat:@"Incorrect password. \n Remaining attempts: %d.",10-[LogicCore loadTry]] delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
                    [alert show];
                    
#endif
                    
                    
                }
        
            }
            else
            {
#ifdef PT
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Erro." message:@"Senha incorreta." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
                [alert show];
                
#endif
                
#ifdef ENG
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error." message:@"Incorrect password." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
                [alert show];
#endif
 
            }
     
        }
        [senha setText:@""];
        [senha resignFirstResponder]; 
        
        
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    if (exitB) 
    {
       exit(0);
    }
}

- (IBAction)start:(id)sender
{
    if ([senha.text length] != 0) 
    {
         
        [senha setText:@""];
    }
}

@end
