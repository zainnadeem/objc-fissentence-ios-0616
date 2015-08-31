# FISSentence

## Objectives

1. Create a custom class with private and `readonly` properties.
2. Write a private "helper" method that assembles an interpretation of private data to show publicly in a `readonly` property.
3. Write private "helper" methods to assess the validity of input through public methods.
4. Write public methods that allow controlled access to the private properties while utilizing the private validation methods to protect the class from incorrect use.

## Introduction

Putting a together a proper sentence can be difficult at times.

![](https://curriculum-content.s3.amazonaws.com/ios-intro-to-objects-unit/men_in_tights_sentence.gif)

In this lab, we're going to write a custom class to handle the logic of how to assemble the individual components (words and punctuation) of a sentence into a single string. We'll then present that string publicly as a read-only property and provide public methods that offer a controlled interface to the privately-held data that is used to form that sentence.

>*Prince John and the Sheriff,  
they was runnin’ the show—  
raisin’ the taxes ‘cause they needed the dough.*  
—[Robin Hood: Men In Tights (1993)](http://www.imdb.com/title/tt0107977/?ref_=nv_sr_3)

Because sentences can be made up of more than one clause with each clause having its own punctuation mark that separates it from the other clauses in the sentence, we're going to hold individual strings in a nested data structure. In our implementation, it will be made up of two levels of arrays: the sub-arrays will contain the individual words held as strings that are grouped together by clause; the parent array will hold the clause-arrays as a group.

```objc
NSArray *clauses = @[ @[ @"Prince", @"John", @"and", @"the", @"Sheriff" ],
                      @[ @"they", @"was", @"runnin'", @"the", @"show" ],
                      @[ @"raisin", @"the", @"taxes", @"'cause", @"they", @"needed", @"the", @"dough" ]
                      ];
```

Because punctuation marks follow different rules than words, we're going to hold them in a separate array but keep them in the same order as the clauses to which they're associated. 

```objc
NSArray *punctuations = @[ @",", @"—", @"." ];
```

By denying public access to the these arrays, we can exert control on how the individual arrays are modified and ensure that one array does not get changed in isolation from the other array. We can then utilize the data held in these arrays to present the information in a specified way to the public:

```
NSString *sentence = @"Prince John and the Sheriff, they was runnin’ the show—raisin’ the taxes ‘cause they needed the dough.";
```

That sounds easy enough!

![](https://curriculum-content.s3.amazonaws.com/ios-intro-to-objects-unit/men_in_tights_deered_a_dare.gif)

Well, maybe not for the Sheriff.

## Instructions

Open the `objc-fissentence.xcworkspace` file.

### I. Set Up the Custom Class Files

Create a custom class called `FISSentence` that inherits from `NSObject`.

#### Properties

In the `FISSentence.h` header file, declare three public properties:

  * a `readonly` property that is an `NSString` called `sentence`,
  * an `NSMutableArray` called `clauses`, and
  * an `NSMutableArray` called `punctuations`.  
  **Top-tip:** *Notice the trailing "s" in the property names. Even though "punctuation" is its own plural form, our code needs to disambiguate the collection's name from the name of its contents. Even though this is linguistically awkward, it's regarding among programmers as best practice to use the trailing "s" character for collection names despite the linguistic inaccuracy.*


In the `FISSentence.m` implementation file, create a private `@interface` section between the `#import` lines and the `@implementation` section with the correct syntax:

```objc
@interface FISSentence ()

@end
```

Within this private `@interface`:

  *  redeclare the `sentence` property as `readwrite`,
 
#### Public Methods

In the `FISSentence.h` header file, declare the eight (8) following public methods, none of which provide a return (i.e. are return-type `void`):

  * `addClause:withPunctuation:` which takes two arguments, an `NSArray` called `clause` and an `NSString` called `punctuation`,

  * `removeClauseAtIndex:` which takes one argument, an `NSUInteger` called `clausesIndex`,

  * `insertClause:withPunctuation:atClausesIndex:` which takes three arguments, an `NSArray` called `clause`, an `NSString` called `punctuation`, and an `NSUInteger` called `clausesIndex`,

  * `replacePunctuationForClauseAtIndex:withPunctuation:` which takes two arguments, an `NSUInteger` called `clausesIndex` and an `NSString` called `punctuation`,

  * `addWord:toClauseAtIndex:` which takes two arguments, an `NSString` called `word` and an `NSUInteger` called `clausesIndex`,

  * `removeWordAtIndex:fromClauseAtIndex:` which takes two arguments, an `NSUInteger` called `wordsIndex` and an `NSUInteger` called `clausesIndex`,

  * `insertWord:atIndex:inClauseAtIndex:` which takes three arguments, an `NSString` called `word`, an `NSUInteger` called `wordIndex`, and an `NSUInteger` called `clauseIndex`, and

  * `replaceWordAtIndex:inClauseAtIndex:withWord:` which takes three arguments, an `NSUInteger` called `wordsIndex`, an `NSUInteger` called `clausesIndex`, and an `NSString` called `word`.

#### Private Methods

Declare a private method called `assembleSentence` with return-type `void`. Leave the implementation empty for now.

Declare the five (5) following private methods that will be used internally to verify the argument values passed into the public methods. All of them should be return-type `BOOL`. Write their implementations to simply `return NO;` for now:

  * `validClause:` which takes one `NSArray` argument called `clause`,
  * `validPunctuation:` which takes one `NSString` argument called `punctuation`,
  * `validClausesIndex:` which takes one `NSUInteger` argument called `clausesIndex`,
  * `validWordsIndex:inClauseAtIndex:` which takes two arguments, an `NSUInteger` called `wordsIndex` and an `NSUInteger` called `clausesIndex`, and
  * `validWord:` which takes one `NSString` argument called `word`.

#### Define Public Method Implementations

Below the private methods, use autocomplete to define the eight (8) public method implementations to do nothing.

### II. Write the Private Method Implementations

In the course of writing the implementation for the public method `addClause:withPunctuation:`, you'll need to write the implementations for some of the private methods, particularly `assembleSentence`.

1. In `addClause:withPunctuation:`, use the `self` keyword to add the `clause` and `punctuation` arguments to the private `clauses` and `punctuations` property arrays (**Hint:** *Use the* `addObject:` *method.*). End the method implementation with a call to `self` of the private `assembleSentence` method.

2. The `assembleSentence` method should read the `clauses` and `punctuations` property arrays and assemble their contents into a properly formatted sentence saved to the `readonly` string property called `sentence`. **This is the most difficult logic that you'll need to write for this lab, so expect to spend the bulk of your time with this implementation.** These steps do not necessarily relate to the order of accomplishing them in your method implementation:
  * Use a `for` loop to iterate over the sub-arrays in the `clauses` property array. Each individual `clause` array of strings should be associated with a punctuation string in the `punctuations` array.
  * Within the loop, use the `componentsJoinedByString:` method to concatenate all of the individual "word" strings in a `clause` array into a regular phrase (i.e. with a space between each word).
  * Append the correct punctuation string for the current phrase to the end of the string holding the concatenation of the individual words.
  * Use the `capitalizedString` property on `NSString` to make sure the first word of the sentence will be capitalized. Do this without overwriting the original string that is held in the first sub-array of the `clauses` property array.
  * Once you've correctly assembled all of the components into a local string variable, set the `sentence` string property to the assembled sentence. This will make it visible outside the current class through accessing the `readonly` string property.

3. Add logic to the `addClause:withPunctuation:` method that validates that the argument inputs meet certain expectations. Get all of the tests for this method to pass: 
  * Check that the `clause` array argument is not empty and is not `nil`.
  * Check that the `punctuation` string argument is not empty and is not `nil`.
  * Verify that the `punctuation` string is one of the following seven (7) characters that can be used to end a sentence or separate clauses: `.?!,;:—` (period, question mark, exclamation point, comma, semicolon, colon, and m-dash).

4. Move the validation logic for these checks into the private `validClause:` and `validPunctuation:` methods. Refactor the `addClause:withPunctuation:` method to call these validation methods instead of doing the checks itself. This will allow other methods to use the same uniform validation logic without having to copy/paste the code. Verify that `addClause:withPunctuation:` still passes all of its tests before moving on.

### III. Write the Public Method Implementations

Continue writing the implementations for the other seven (7) public methods. **All of the public methods should end with a call of the `assembleSentence` method to update the `sentence` property string with the new information.**

1. The `removeClauseAtIndex:` method should remove a clause sub-array from the `clauses` property array **and its associated punctuation string** from the `punctuations` property array. Add in a check the makes sure the `clausesIndex` argument is not beyond the bounds of either the `clauses` property array or the `punctuations` property array; this method should not attempt to remove a clause that doesn't exist.

2. Move the validation logic for the `clausesIndex` argument out of the `removeClauseAtIndex:` method and into `validClausesIndex:`. Refactor `removeClauseAtIndex:` to use the `validClausesIndex:` method to perform the check. Verify that the tests for `removeClauseAtIndex:` continue to pass before moving on.

3. The `insertClause:withPunctuation:atClausesIndex:` method should insert the submitted `clause` and `punctuation` arguments into the `clauses` and `punctuations` property arrays at the specified index number. Use the private validation methods to perform checks on each of the three method arguments, and to only attempt to change the private property arrays if all three of the arguments pass validation.

4. The `replacePunctuationforClauseAtIndex:withPunctuation:` method should overwrite the string in the `punctuations` property array at the specified `clausesIndex` with the new `punctuation` argument string (remember that the indexes for the `punctuations` array are associated with and should always match the indexes of the `clauses` array). This method should only attempt to make the change if both of the arguments pass validation.

5. The `addWord:toClauseAtIndex:` method should add the `word` argument string to the end of the sub-array held in the `clauses` property array at the specified index argument.
  * You should see a stack trace read out in the debug console (that means the program crashed!). Add the All-Exceptions breakpoint to see if you can track it down yourself. 
  ![](https://curriculum-content.s3.amazonaws.com/ios-intro-to-objects-unit/men_in_tights_air_five.gif)
  * What you'll need do to is refactor the `addClause:withPunctuation:` and the `insertClause:withPunctuation:atClausesIndex:` methods to make a **mutable copy** of the submitted `clause` argument array and adding that mutable copy to the `clauses` property array instead of the immutable array itself. Apply this change and the stack trace should resolve itself.
  * Add a check that makes sure the `word` string argument is not an empty string or `nil`, and that the `clausesIndex` argument is not beyond the bounds of the `clauses` array. Verify that all of the tests for this method pass before moving on.

6. Refactor the `addWord:toClauseAtIndex:` to move the validation of its `word` string argument into the private `validWord:` method. Verify that all the tests on `addWord:toClauseAtIndex:` continue to pass before moving on.

7. The `removeWordAtIndex:fromClauseAtIndex:` method should remove the string at the specified `wordsIndex` of the sub-array contained in the `clauses` property array at the specified `clausesIndex`. This method should use the `validClausesIndex:` method to avoid removing a sub-array that doesn't exist. Similarly, add a check that makes sure there is a string in the specified sub-array at the index number specified by the `wordsIndex` argument. **This method should not attempt to remove a string that does not exist.** Verify that all of the tests for this method pass before moving on.

8. Refactor the `removeWordAtIndex:fromClauseAtIndex:` method to move the validation of the `wordsIndex` argument into the private `validWordsIndex:` method. Verify that all of the tests on `removeWordAtIndex:fromClauseAtIndex:` continue to pass before moving on.

9. The `insertWord:atIndex:inClauseAtIndex:` method should add the `word` string argument into the sub-array in the `clauses` property array specified by the `clausesIndex` argument at the sub-array's index specified by the `wordsIndex:` argument. This method should not attempt the to make an insertion unless its arguments pass the `validWord:`, `validClausesIndex:`, and `validWordsIndex:` checks.

10. The `replaceWordAtIndex:inClauseAtIndex:withWord:` method should overwrite the string in the sub-array of the `clauses` property specified by the `clausesIndex` argument at the sub-array index specified by the `wordsIndex` argument. This method should not attempt to make an overwrite unless its arguments pass the `validWord:`, `validClausesIndex:`, and `validWordsIndex:` checks.

Once all of the tests pass, celebrate with a little dance number. You deserve it!

![](https://curriculum-content.s3.amazonaws.com/ios-intro-to-objects-unit/men_in_tights_chorus_line.gif)

## Advanced

Did you notice, however, that the `clauses` and `punctuations` arrays that we stored the data in were public? Ideally these would be private and not even visible to the public, but since we needed to make them mutable arrays they had to be initialized in the test file (reference the `beforeEach` block in the spec file to see this).

In order to initialize private properties so they can used internally by method implementations, a special method called an "initializer" can be written to set these private properties to default values. In the case of our mutable arrays, they can be initialized to empty arrays so that they're prepared to receive method calls that change their data.