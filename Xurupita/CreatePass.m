//  Created by Sir Cheshire

#import "CreatePass.h"
#import "LogicCore.h"

@implementation CreatePass
@synthesize purgeButton;
@synthesize okButton;
@synthesize navItem;
@synthesize recButton;
@synthesize aceitButton;
@synthesize contrato;
@synthesize botRet;
@synthesize labelPassOne;
@synthesize labelPassTwo;

@synthesize senhaOld;
@synthesize senhaUm;
@synthesize senhaDois;
@synthesize labelOld;

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

-(void) changeEnglish
{
    NSLog(@"change english");
    
    [labelOld setText:@"Old Password"];
    [labelPassOne setText:@"New Password"];
    [labelPassTwo setText:@"Repeat New Password"];
    [okButton setTitle:@"Define Password" forState:UIControlStateNormal];
    [navItem setTitle:@"Define your Password"];
    [botRet setTitle:@"Return" forState:UIControlStateNormal];
    [aceitButton setTitle:@"Agree" forState:UIControlStateNormal];
    [recButton setTitle:@"Disagree" forState:UIControlStateNormal];
    [contrato setText:@"Terms of Use\n\nThe content and accuracy of data entered in the Application Safe Docs (and versions) is the responsibility of the user. The TM4 Tecnologia LTDA does not store or transmit user's data in any way. The data is stored locally by the application on the user's device (iPhone, iPad, and / or iPod Touch) and can be sent by e-mail manually as needed by the user.\nTM4 Tecnologia LTDA have no liability arising out of the relationship between the USER (S), whether direct or indirect, and / or as well;\nA- For damages and / or losses arising from transactions made between Users and third parties.\nB- The origin, quality and veracity of the documents stored in the Application Safe Docs (and versions), and their full and sole responsibility of the user.\nC- For transactions made \"online\" on the Internet, which are the sole and exclusive responsibility of those who provide their products or services.\nD- For data accessed by third parties in an attempt to bypass the password system in this application.\nE- For access content by third parties and / or malicious software.\nRemember, the storage of your documents in Safe Docs does not have public trust, therefore, not exempt him from presenting them if they are requested by Police Authority.\nSo the TM4 Tecnologia LTDA is not responsible for any act or omission of the USER (S) based on the information, pictures or other material inserted in Safe Docs (and versions).\n\nTM4 Tecnologia LTDA suggests the USERS(S) that:\nA- Enroll your password and keep confidential;\nB- Be careful with the data from their individual identification each time you access the Internet, informing them only in transactions in which there are data protection;\nC- Take any other action necessary to protect itself from harm, including fraud or embezzlement \"online\";\nD- Strictly observe all the provisions of this TERMS OF USE.\n\nIf you have any questions please contact through e-mail contato@br4games.com.br"];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundPattern.png"]]];
    
    if ([LogicCore loadGreed]) 
    {
        [contrato setHidden:YES];
        [recButton setHidden:YES];
        [aceitButton setHidden:YES];
    }
    else
    {
        [botRet setEnabled:NO];
    }
    
#ifdef ENG
    [self changeEnglish];
#endif
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    [label setTextAlignment:UITextAlignmentCenter];
	[label setFont:[UIFont boldSystemFontOfSize:16.0]];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor colorWithRed:57.0/255.0 green:54.0/255.0 blue:40.0/255.0 alpha:1.0]];
    
	[label setText:navItem.title];
	[navItem setTitleView:label];
    
    if ([LogicCore loadPass] == nil) 
    {
        [botRet setEnabled:NO];
        [senhaOld setHidden:YES];
        [labelOld setHidden:YES];
        
        [LogicCore savePass:@""];
    }
    else
    {
        if ([[LogicCore loadPass] length] == 0) 
        {
            [labelOld setHidden:YES];
            [senhaOld setHidden:YES];
        }
    }
    
    LogicCore* core = [[LogicCore alloc] init];
    
    [purgeButton setOn:[core loadPurge]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSenhaUm:nil];
    [self setSenhaDois:nil];
    [self setSenhaOld:nil];
    [self setLabelOld:nil];
    [self setPurgeButton:nil];
    [self setOkButton:nil];
    [self setNavItem:nil];
    [self setRecButton:nil];
    [self setAceitButton:nil];
    [self setContrato:nil];
    [self setBotRet:nil];
    [self setLabelPassOne:nil];
    [self setLabelPassTwo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}


- (IBAction)check:(id)sender 
{
    if (sender == senhaUm && [senhaUm.text length] != 0) 
    {
        [senhaUm setText:@""];
    }
    
    if (sender == senhaDois && [senhaDois.text length] != 0) 
    {
        [senhaDois setText:@""];
    }
    if (sender == senhaOld && [senhaOld.text length] != 0) 
    {
        [senhaDois setText:@""];
    }
}

- (IBAction)checkDois:(id)sender 
{
    if (sender == senhaUm && [senhaUm.text length] == 4) 
    {
        [senhaUm resignFirstResponder];
    }
    
    if (sender == senhaDois && [senhaDois.text length] == 4) 
    {
        [senhaDois resignFirstResponder];
    }
    if (sender == senhaOld && [senhaOld.text length] == 4) 
    {
        [senhaOld resignFirstResponder];
    }
}

- (IBAction)create:(id)sender 

{
    if ([senhaUm.text isEqualToString:senhaDois.text]) 
    {
        if (([senhaUm.text length] != 4) && ([senhaUm.text length] > 0)) 
        {
#ifdef PT
            UIAlertView *alert = 
            [[UIAlertView alloc] initWithTitle:@"Erro." message: @"A senha precisa ter 4 caracteres." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [alert show];  
#endif
            
#ifdef ENG
            UIAlertView *alert = 
            [[UIAlertView alloc] initWithTitle:@"Error." message: @"Password must be 4 letters long." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [alert show];
            
#endif
        } 
        else if (![senhaOld isHidden] && ![senhaOld.text isEqualToString:[LogicCore loadPass]]) 
        {
#ifdef PT
            UIAlertView *alert = 
            [[UIAlertView alloc] initWithTitle:@"Erro." message: @"Senha antiga incorreta." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [alert show];  
#endif
            
#ifdef ENG
            UIAlertView *alert = 
            [[UIAlertView alloc] initWithTitle:@"Error." message: @"Incorrect old password." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [alert show];
            
#endif
            [senhaUm setText:@""];
            [senhaDois setText:@""];
            [senhaOld setText:@""];
        } 
        else
        {
            [LogicCore savePass:senhaDois.text];
            [self dismissModalViewControllerAnimated:YES];
        }
    }
    else
    {
#ifdef PT
        UIAlertView *alert = 
        [[UIAlertView alloc] initWithTitle:@"Erro." message: @"Senhas diferentes." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [alert show];
        
#endif
        
#ifdef ENG
        UIAlertView *alert = 
        [[UIAlertView alloc] initWithTitle:@"Error." message: @"Different passwords." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [alert show];
        
#endif

        [senhaUm setText:@""];
        [senhaDois setText:@""];
        [senhaOld setText:@""];
    }
}

- (IBAction)retornar:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)checkPurge:(id)sender 
{
    if ([senhaOld.text isEqualToString:[LogicCore loadPass]] && ![[LogicCore loadPass] isEqualToString:@""]) 
    {
        LogicCore* core = [[LogicCore alloc] init];
        [core savePurge:[purgeButton isOn]];
    }
    else
    {
        if (![[LogicCore loadPass] isEqualToString:@""]) 
        {
            LogicCore* core = [[LogicCore alloc] init];
            [purgeButton setOn:[core loadPurge]];

#ifdef PT
            UIAlertView *alert = 
            [[UIAlertView alloc] initWithTitle:@"Erro." message: @"Para configurar o Auto Purge você precisa inserir sua senha corretamente." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [alert show];
            
#endif
            
#ifdef ENG
            UIAlertView *alert = 
            [[UIAlertView alloc] initWithTitle:@"Error." message: @"In order to configure the Auto Purge you must insert your password correctly." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [alert show];
#endif
        }
        else
        {
            LogicCore* core = [[LogicCore alloc] init];
            [core savePurge:[purgeButton isOn]];
            
#ifdef PT
            UIAlertView *alert = 
            [[UIAlertView alloc] initWithTitle:@"Aviso." message: @"O Auto Purge não possui efeito enquanto nenhuma senha for definida." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [alert show];
            
#endif
#ifdef ENG
            UIAlertView *alert = 
            [[UIAlertView alloc] initWithTitle:@"Warning." message: @"Auto Purge wont have any effects until a password is set." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [alert show];
#endif
        }
    }
}

- (IBAction)infoPurge:(id)sender
{
#ifdef PT
    UIAlertView *alert = 
    [[UIAlertView alloc] initWithTitle:@"Auto Purge." message: @"O Auto Purge é um sistema extra de segurança. Quando ativado, o aplicativo irá deletar todos os dados guardados nele caso ocorram dez tentativas consecutivas de login incorretas." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [alert show];
    
#endif
    
#ifdef ENG
    UIAlertView *alert = 
    [[UIAlertView alloc] initWithTitle:@"Auto Purge." message: @"Auto Purge is an extra security system. When activated, the app will delete all data stored in it if ten failed login attempts occours." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [alert show];
#endif
    
}
- (IBAction)recusar:(id)sender 
{
    exit(0);
}

- (IBAction)aceitar:(id)sender 
{
    [LogicCore saveAgreed];
    [contrato setHidden:YES];
    [recButton setHidden:YES];
    [aceitButton setHidden:YES];
    [botRet setEnabled:YES];
}

@end
