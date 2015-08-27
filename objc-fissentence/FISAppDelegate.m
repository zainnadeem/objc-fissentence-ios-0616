//  FISAppDelegate.m

#import "FISAppDelegate.h"
#import "FISSentence.h"

@interface FISAppDelegate ()

@end


@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    FISSentence *welcome = [[FISSentence alloc] init];
    
    [welcome addClause:@[ @"welcome", @"to", @"the", @"Flatiron", @"School"] withPunctuation:@"!"];
    
    FISSentence *hello = [[FISSentence alloc] init];
    
    [hello addClause:@[ @"hello" ] withPunctuation:@","];
    [hello addClause:@[ @"my", @"name", @"is", @"Inigo", @"Montoya" ] withPunctuation:@"!"];
    
    [hello addClause:@[ @"You", @"killed", @"my", @"father"] withPunctuation:@";"];
    
    [hello addClause:@[ @"prepare", @"to", @"die"] withPunctuation:@"."];
    
    return YES;
}

@end
