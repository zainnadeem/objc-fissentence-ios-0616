//  FISSentence.m

#import "FISSentence.h"

@interface FISSentence ()

@property (strong, nonatomic, readwrite) NSMutableArray *clauses;
@property (strong, nonatomic, readwrite) NSMutableArray *punctuations;
@property (strong, nonatomic, readwrite) NSString *sentence;

@end

@implementation FISSentence

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _clauses = [[NSMutableArray alloc]init];
        _punctuations = [[NSMutableArray alloc] init];
        _sentence = @"";
    }
    
    return self;
}

- (void)assembleSentence {
    NSMutableString *sentence = [[NSMutableString alloc] initWithString:@""];
    for (NSUInteger i = 0; i < self.clauses.count; i++) {
        NSMutableArray *currentClause = self.clauses[i];
        if (i == 0) {
            NSString *firstWord = currentClause[0];
            currentClause[0] = firstWord.capitalizedString;
        }
        NSMutableString *phrase = [[currentClause componentsJoinedByString:@" "] mutableCopy];
        [phrase appendString:self.punctuations[i]];
        if (i > 0) {
            [phrase insertString:@" " atIndex:0];
        }
        NSLog(@"%@", phrase);
        [sentence appendString:phrase];
    }
    self.sentence = sentence;
    NSLog(@"%@", self.sentence);
}

- (BOOL)validClause:(NSArray *)clause {
    if (clause == nil) {
        return NO;
    }
    if (clause.count == 0) {
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
    if (index > self.clauses.count) {
        return NO;
    }
    if (index > self.punctuations.count) {
        return NO;
    }
    return YES;
}

- (BOOL)validClauseIndex:(NSUInteger)clauseIndex inClauseAtIndex:(NSUInteger)index {
    BOOL validIndex = [self validIndex:index];
    if (!validIndex) {
        return NO;
    }
    
    NSArray *clause = self.clauses[index];
    if (clauseIndex > clause.count) {
        return NO;
    }
    return YES;
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

- (void)addClause:(NSArray *)clause withPunctuation:(NSString *)punctuation {
    BOOL validClause = [self validClause:clause];
    BOOL validPunctuation = [self validPunctuation:punctuation];
    
    if (validClause && validPunctuation) {
        NSMutableArray *mutableClause = [clause mutableCopy];
        [self.clauses addObject:mutableClause];
        [self.punctuations addObject:punctuation];
    }
    [self assembleSentence];
}

- (void)removeClauseAtIndex:(NSUInteger)index {
    BOOL validIndex = [self validIndex:index];
    
    if (validIndex) {
        [self.clauses removeObjectAtIndex:index];
        [self.punctuations removeObjectAtIndex:index];
    }
    [self assembleSentence];
}

- (void)insertClause:(NSArray *)clause
     withPunctuation:(NSString *)punctuation
             atIndex:(NSUInteger)index {
    BOOL validClause = [self validClause:clause];
    BOOL validPunctuation = [self validPunctuation:punctuation];
    BOOL validIndex = [self validIndex:index];
    
    
    if (validClause && validPunctuation && validIndex) {
        [self.clauses insertObject:clause atIndex:index];
        [self.punctuations insertObject:punctuation atIndex:index];
    }
    [self assembleSentence];
}

- (void)replacePunctuationForClauseAtIndex:(NSUInteger)index
                             toPunctuation:(NSString *)punctuation {
    BOOL validIndex = [self validIndex:index];
    BOOL validPunctuation = [self validPunctuation:punctuation];
    
    if (validIndex && validPunctuation) {
        self.punctuations[index] = punctuation;
    }
    [self assembleSentence];
}

- (void)addWord:(NSString *)word toClauseAtIndex:(NSUInteger)index {
    BOOL validWord = [self validWord:word];
    BOOL validIndex = [self validIndex:index];
    
    if (validWord && validIndex) {
        [self.clauses[index] addObject:word];
    }
    [self assembleSentence];
}

- (void)removeWordFromClauseAtIndex:(NSUInteger)index
                      atClauseIndex:(NSUInteger)clauseIndex {
    BOOL validIndex = [self validIndex:index];
    BOOL validClauseIndex = [self validClauseIndex:clauseIndex inClauseAtIndex:index];
    
    if (validIndex && validClauseIndex) {
        [self.clauses[index] removeObjectAtIndex:clauseIndex];
    }
    
    [self assembleSentence];
}

- (void)insertWord:(NSString *)word
   inClauseAtIndex:(NSUInteger)index
     atClauseIndex:(NSUInteger)clauseIndex {
    BOOL validWord = [self validWord:word];
    BOOL validIndex = [self validIndex:index];
    BOOL validClauseIndex = [self validClauseIndex:clauseIndex inClauseAtIndex:index];
    
    if (validWord && validIndex && validClauseIndex) {
        [self.clauses[index] insertObject:word atIndex:clauseIndex];
    }
    
    [self assembleSentence];
}

@end
