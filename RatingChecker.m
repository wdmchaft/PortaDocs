
#import "RatingChecker.h"

@implementation RatingChecker

+(BOOL) askForReview
{
    BOOL ret = NO;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"finalizado.txt"]];
    
    NSString* finalizou = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
    
    if (![finalizou isEqualToString:@"YES"]) 
    {
        fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ultimaPergunta.txt"]];
        
        NSString* ultimaChecagem = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
        
         NSLog(@"ultima checkagem %@",ultimaChecagem);
        
        if ([ultimaChecagem length] > 1) 
        {
            NSDateFormatter* format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            [format setTimeZone:[NSTimeZone localTimeZone]];
            
            NSDate* fim = [format dateFromString:ultimaChecagem];
            
            NSTimeInterval restante = [fim timeIntervalSinceDate:[NSDate new]];  
            
            int minutes = floor(restante/60);
            
            int hours = floor(minutes/60);
            
            minutes = minutes- (hours*60);
            
            int days = floor(hours/24);
            
            hours = hours - (days*24);
            
            int seconds = trunc(restante-(minutes*60));
            
            //aqui determino se ja deu tempo suficiente pra perguntar de novo
            if (days >= 1) 
            {
                ret = TRUE;
            } 
        } 
        else
        {
            [RatingChecker saveCheckInDate];
        }
    }
    
    return ret;
}

+(void) saveCheckInDate
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ultimaPergunta.txt"]];
    
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [format setTimeZone:[NSTimeZone localTimeZone]];

    NSString* dataAtual = [format stringFromDate:[NSDate new]];
    
    [dataAtual writeToFile:fullPath atomically:NO encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"salvou %@",dataAtual);
}

+(void) finalizar
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"finalizado.txt"]];
    
    NSString* finalizado = [NSString stringWithFormat:@"YES"];
    
    [finalizado writeToFile:fullPath atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

@end
