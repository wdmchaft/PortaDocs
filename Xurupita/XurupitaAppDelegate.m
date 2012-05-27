//  Created by Sir Cheshire

#import "XurupitaAppDelegate.h"
#import "Login.h"
#import "XurupitaViewController.h"
#import "LogicCore.h"
#import "CreatePass.h"
#import "RatingChecker.h"

@implementation XurupitaAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

/* 
1- documentos desaparecendo no update 
    [o documento existe, não mostra as imagens] 
    [imagens ainda existentes na lista do documento?]
    [relação com 3?]
    [talvez estoure alguma coisa e não consiga a partir de um ponto?]
 
 
2- nao aparece a imagem apos selecionar
    [testado no ipad2, não foi possivel reproduzir,tanto camera como biblioteca]
 
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    // Point to Document directory
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    // Write out the contents of home directory to console
    NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil]);

    self.window.rootViewController = self.viewController;

    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    if (!([LogicCore loadPass] == nil || [[LogicCore loadPass] isEqualToString:@""])) 
    {
        [self.window.rootViewController dismissModalViewControllerAnimated:YES];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if ([RatingChecker askForReview]) 
    {
        NSString* titulo;
        NSString* yes;
        NSString* no;
        NSString* later;
        
#ifdef PT
        
        titulo = @"Deseja avaliar este app na appstore?";
        yes = @"Sim";
        no = @"No";
        later = @"Me lembre depois";
#endif 
        
#ifdef ENG
        titulo = @"Do you wish to rate this app at appstore?";
        yes = @"Yes";
        no = @"No";
        later = @"Ask me later";
#endif
        
        UIActionSheet* ratingSheet = [[UIActionSheet alloc] initWithTitle:titulo delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:yes,no,later, nil];
        
        [ratingSheet showInView:self.window.rootViewController.view];
    } 
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   NSString* appid = [NSString stringWithFormat:@""];
    
    
    /*
     Safe Docs HD Lite
     http://itunes.apple.com/us/app/safe-docs-hd-lite/id474210531?l=pt&ls=1&mt=8
     Safe Docs Lite
     http://itunes.apple.com/us/app/safe-docs-lite/id474210212?l=pt&ls=1&mt=8
     Safe Docs HD
     http://itunes.apple.com/us/app/safe-docs-hd/id474209487?l=pt&ls=1&mt=8
     Safe Docs
     http://itunes.apple.com/us/app/safe-docs/id474209475?l=pt&ls=1&mt=8
     Porta Docs HD Lite
     http://itunes.apple.com/us/app/porta-docs-hd-lite/id474209248?l=pt&ls=1&mt=8
     Porta Docs Lite
     http://itunes.apple.com/us/app/porta-docs-lite/id474206063?l=pt&ls=1&mt=8
     Porta Docs HD
     http://itunes.apple.com/us/app/porta-docs-hd/id474206057?l=pt&ls=1&mt=8
     Porta Docs
     http://itunes.apple.com/us/app/porta-docs/id473020557?l=pt&ls=1&mt=8
     */
#ifdef LITE
    
#ifdef PT
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
    {
     //porta hd lite  
        
        appid = @"474209248";
    }
    else
    {
        //porta lite
        appid = @"474206063";
    }
#endif
    
#ifdef ENG
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
    {
        //safe hd lite
        appid = @"474210531";
    }
    else
    {
        //safe lite
        appid = @"474210212";
    }
#endif
    
#endif
   
    
#ifdef FULL
    
#ifdef PT
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
    {
        //porta hd 
        appid = @"474206057";
    }
    else
    {
        //porta
        appid = @"473020557";
    }
#endif
    
#ifdef ENG
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
    {
        //safe hd
        appid = @"474209487";
    }
    else
    {
        //safe
        appid = @"474209475";
    }
#endif
    
#endif
    
    if (buttonIndex == 0) 
    {
        NSString* url = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8", appid];
        //http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=473020557&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8
        
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url ]];
        
        [RatingChecker finalizar];
    }
    else if(buttonIndex == 1)
    {
        [RatingChecker finalizar];
    }
    else if(buttonIndex == 2)
    {
        [RatingChecker saveCheckInDate];
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


@end
