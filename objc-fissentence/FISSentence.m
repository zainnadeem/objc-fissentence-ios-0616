//
//  FISSentence.m
//  objc-fissentence
//
//  Created by Zain Nadeem on 6/9/16.
//  Copyright © 2016 The Flatiron School. All rights reserved.
//

#import "FISSentence.h"

@interface FISSentence ()
@property (strong, nonatomic) NSString *sentence;

@end


@implementation FISSentence

-(void)assembleSentence{
    NSString *arrayJoinedIntoString = [self.words componentsJoinedByString:@" "];
    self.sentence =[NSString stringWithFormat:@"%@%@", arrayJoinedIntoString,self.punctuation];
    NSLog(@"%@ %@######################", arrayJoinedIntoString,self.punctuation);
}

-(BOOL)validWord:(NSString*)word{
    BOOL validWord;
    if([word isEqualToString:@""]){
        validWord = false;
    }else if([word isEqualToString:@" "]){
        validWord = false;
    }else if(word == nil){
        validWord = false;
    }else{
        validWord= true;
    }
    return validWord;
}

-(BOOL)validPunctuation:(NSString*)punctuation{
    BOOL validPunc;
    NSArray *punctutationCharacters = @[@".", @",", @"?", @"!", @";" ,@":", @"—"];
    if([punctutationCharacters containsObject:punctuation]){
        validPunc = true;
    }
    else{
        validPunc= false;
    }
    return validPunc;
}

-(BOOL)validIndex:(NSUInteger)index{
    BOOL validIndex;
    if (index < self.words.count){
        validIndex = true;
        //[self.words removeObjectAtIndex:index];
    }else{
        validIndex= false;
    }
    return validIndex;
}

-(void)addWord:(NSString *)word{
    if([self validWord:word]){
        [self.words addObject:word];
    }
    [self assembleSentence];
    
}

-(void)addWords:(NSArray *)words withPunctuation: (NSString *)punctuation{
    if([words isEqualToArray:@[]]){
        return;
    }else if(words == nil){
        return;
    }else{
        for( NSString* word in words){
            if([self validPunctuation:punctuation]){
                [self addWord:word];
                self.punctuation = punctuation;
            }
        }
    }
    [self assembleSentence];
    
}

-(void)removeWordAtIndex:(NSUInteger)index{
    if([self validIndex:index]){
        [self.words removeObjectAtIndex:index];
    }
    [self assembleSentence];
}
-(void)insertWord:(NSString *)word atIndex:(NSUInteger)index{
    
    if(([self validWord:word]) && ([self validIndex:index])){
        NSLog(@"%@-------------------------------------", self.words);
        [self.words insertObject:word atIndex:index];
        NSLog(@"%@-------------------------------------", self.words);
    }
    [self assembleSentence];
    NSLog(@"%@-------------------------------------", self.words);
    
}
-(void)replacePunctuationWithPunctuation:(NSString *)punctuation{
    if([self validPunctuation:punctuation]){
        self.punctuation = punctuation;
    }
    
    [self assembleSentence];
    
}
-(void)replaceWordAtIndex:(NSUInteger)index withWord: (NSString *)word{
    if(([self validWord:word]) && ([self validIndex:index])){
        [self.words replaceObjectAtIndex:index withObject:word];
    }
    [self assembleSentence];
    
}

@end
