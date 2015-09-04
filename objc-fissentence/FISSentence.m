//  FISSentence.m

#import "FISSentence.h"

@interface FISSentence ()

@property (strong, nonatomic, readwrite) NSString *sentence;

@end

@implementation FISSentence

- (void)assembleSentence {
    NSString *phrase = [self.words componentsJoinedByString:@" "];
    phrase = [phrase stringByAppendingString:self.punctuation];
    
    self.sentence = phrase;
}

- (BOOL)validWord:(NSString *)word {
    if (word == nil) {
        return NO;
    }
    if ([word isEqualToString:@" "]) {
        return NO;
    }
    if (word.length == 0) {
        return NO;
    }
    return YES;
}

- (BOOL)validPunctuation:(NSString *)punctuation {
    if (punctuation == nil) {
        return NO;
    }
    NSString *validPunctuation = @".?!,;:—";
    if (![validPunctuation containsString:punctuation]) {
        return NO;
    }
    return YES;
}

- (BOOL)validIndex:(NSUInteger)index {
    if (index >= self.words.count) {
        return NO;
    }
    return YES;
}

- (void)addWord:(NSString *)word {
    BOOL validWord = [self validWord:word];
    
    if (validWord) {
        [self.words addObject:word];
    }
    
    [self assembleSentence];
}


- (void)addWords:(NSArray *)words withPunctuation:(NSString *)punctuation {
    if ([words isEqualToArray:@[]] || words == nil) {
        return;
    }
    
    BOOL validPunctuation = [self validPunctuation:punctuation];
    
    if (!validPunctuation) {
        return;
    }
    
    self.punctuation = punctuation;
    
    for (NSString *word in words) {
        BOOL validWord = [self validWord:word];
        if (validWord) {
            [self.words addObject:word];
        }
    }
    
    [self assembleSentence];
}

- (void)removeWordAtIndex:(NSUInteger)index {
    BOOL validIndex = [self validIndex:index];
    
    if (validIndex) {
        [self.words removeObjectAtIndex:index];
    }
    
    [self assembleSentence];
}

- (void)insertWord:(NSString *)word atIndex:(NSUInteger)index {
    BOOL validWord = [self validWord:word];
    BOOL validIndex = [self validIndex:index];
    
    if (validWord && validIndex) {
        [self.words insertObject:word atIndex:index];
    }
    
    [self assembleSentence];
}

- (void)replacePunctuationWithPunctuation:(NSString *)punctuation {
    BOOL validPunctuation = [self validPunctuation:punctuation];
    
    if (validPunctuation) {
        self.punctuation = punctuation;
    }
    
    [self assembleSentence];
}

- (void)replaceWordAtIndex:(NSUInteger)index withWord:(NSString *)word {
    BOOL validIndex = [self validIndex:index];
    BOOL validWord = [self validWord:word];
    
    if (validIndex && validWord) {
        [self.words replaceObjectAtIndex:index withObject:word];
    }
    
    [self assembleSentence];
}

@end
