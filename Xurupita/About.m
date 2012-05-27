//  Created by Sir Cheshire

#import "About.h"
#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation About
@synthesize labelTop;
@synthesize botRet;
@synthesize aboutFull;
@synthesize fundoBarra;
@synthesize navItem;
@synthesize textoSmall;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef PT
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [fundoBarra setImage:[UIImage imageNamed:@"FundoBr4GamesIpad.png"]];
    }
    [textoSmall setText:@"Versão 2.1\nBr4 Games Copyright © 2011\nTodos os direitos reservados"];
#endif
    
    
    
#ifdef ENG
    
    [aboutFull setText:@"Safe Docs helps you to organize and access all your personal documents, easily, fast, secure and in a intuitive way wherever you are. How many times you needed documents that was not in your pocket? With Safe Docs you can store all of your personal documents, access very fast and send by email for who you want.\nYou can travel and bring all your documents wihout care about something is missing.\nStore all your credit cards and pay your online bills.\nHave all your fidelity cards in your hand and never lose your bonus.\n\n-SECURITY\nSafe Docs allows you to define a password to access your personal documents. With the password set, you have to type the passcode to grant access to the documents. Every time that the App is closed or minimized the password is requested.\nIf you are looking for more security you can enable the Auto Purge service. The system will detect multiple 10 wrong tries and erase all the documents for your entire security.\n\n*FEATURES\n- Store unlimited personal documents;\n- Save Front and Back of the documents;\n- Choose which documents you want to send by email;\n- Add photos by your Camera Roll or Take a Photo;\n- Edit your photo in real time before define to your document;\n- Define a secure password for your personal documents;\n- Automaticly erase all your documents with mutiple wrong attemps;\n- Includes a generic documents if its not listed;\n- Organize documents by icons and specific names;\n\n*DOCUMENTS LIST\n- ID\n- Driver's License\n - School ID\n- Birth Certificate\n- U.S. Military Card\n- Passport\n- Rewards Card\n- Vip Card\n- Business Card\n- Insurance Card\n- Residency Certification\n- Voter Registration\n- Visa\n- MasterCard\n- Diners Club\n- American Express\n- Aura\n- Hipercard\n- Health Insurance\n- Other\n"];
    [labelTop setText:@"Safe Docs"];
    [textoSmall setText: @"Version 2.1\nBr4 Games Copyright © 2011\nAll rights reserved"];
    
    [botRet setTitle:@"Return" forState:UIControlStateNormal];
    [navItem setTitle:@"About"];
    
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
     {
         [fundoBarra setImage:[UIImage imageNamed:@"FundoBr4GamesIpadIngles.png"]];
     }
     else
    {
        [fundoBarra setImage:[UIImage imageNamed:@"FundoBr4GamesIngles.png"]];
    }
    
    
    
#endif
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    [label setTextAlignment:UITextAlignmentCenter];
	[label setFont:[UIFont boldSystemFontOfSize:16.0]];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor colorWithRed:57.0/255.0 green:54.0/255.0 blue:40.0/255.0 alpha:1.0]];
    
	[label setText:navItem.title];
	[navItem setTitleView:label];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundPattern.png"]]];
}

- (void)viewDidUnload
{
    [self setTextoSmall:nil];
    [self setLabelTop:nil];
    [self setAboutFull:nil];
    [self setFundoBarra:nil];
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

- (IBAction)return:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)clickLogo:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.br4games.com.br"]];
}

- (IBAction)clickFB:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/pages/BR4-Games-Studio/153936741331356"]];
}

- (IBAction)clickTwitter:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/#!/br4games"]];
}

- (IBAction)clickMail:(id)sender 
{
    MFMailComposeViewController *mailComposer; 
    mailComposer  = [[MFMailComposeViewController alloc] init];
    
    mailComposer.mailComposeDelegate = self;
    [mailComposer setModalPresentationStyle:UIModalPresentationFormSheet];
    [mailComposer setSubject:@""];
    [mailComposer setToRecipients:[NSArray arrayWithObject:@"contato@br4games.com.br"]];
    [mailComposer setMessageBody:[NSString stringWithFormat:@""] isHTML:NO];
    [mailComposer.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    [self presentModalViewController:mailComposer animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{ 
    [self dismissModalViewControllerAnimated:YES];
    return;
}
@end
