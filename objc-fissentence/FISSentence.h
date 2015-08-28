//  FISSentence.h

#import <Foundation/Foundation.h>

@interface FISSentence : NSObject

@property (strong, nonatomic, readonly) NSString *sentence;

- (void)addClause:(NSArray *)clause withPunctuation:(NSString *)punctuation;

- (void)removeClauseAtIndex:(NSUInteger)clausesIndex;

- (void)insertClause:(NSArray *)clause
     withPunctuation:(NSString *)punctuation
      atClausesIndex:(NSUInteger)clausesIndex;

- (void)replacePunctuationForClauseAtIndex:(NSUInteger)clausesIndex
                           withPunctuation:(NSString *)punctuation;

- (void)addWord:(NSString *)word toClauseAtIndex:(NSUInteger)clausesIndex;

- (void)removeWordAtIndex:(NSUInteger)wordsIndex
        fromClauseAtIndex:(NSUInteger)clausesIndex;

- (void)insertWord:(NSString *)word
           atIndex:(NSUInteger)wordIndex
   inClauseAtIndex:(NSUInteger)clauseIndex;

- (void)replaceWordAtIndex:(NSUInteger)wordsIndex
           inClauseAtIndex:(NSUInteger)clausesIndex
                  withWord:(NSString *)word;

@end
