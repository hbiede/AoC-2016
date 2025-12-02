#include <stdio.h>
#include <limits.h>

#include "Foundation/Foundation.h"

NSString *solve(NSString *input, BOOL isMost) {
  NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, NSNumber *> *> *counts = [[NSMutableDictionary alloc] init];
  
  NSArray *lines = [input componentsSeparatedByString:@"\n"];
  for (int i=0; i<[[lines objectAtIndex:0] length]; i++) {
    NSString *key = [NSString stringWithFormat:@"%d", i];
    [counts setObject:[[NSMutableDictionary alloc] init] forKey:key];
      
    for (NSString *line in lines) {
      NSMutableDictionary *indexFrequencies = [counts objectForKey:key];
      NSString *letter = [NSString stringWithFormat:@"%c", [line characterAtIndex:i]];
      if ([indexFrequencies objectForKey:letter]) {
        NSNumber *curr = [indexFrequencies objectForKey:letter];
        [indexFrequencies setValue:@(curr.intValue + 1) forKey:letter];
      } else {
        [indexFrequencies setValue:@(1) forKey:letter];
      }
    }
  }
  
  NSMutableString *res = [[NSMutableString alloc] initWithString:@""];
  for (int i=0; i<[[lines objectAtIndex:0] length]; i++) {
    NSString *selection = @"";
    int selectionCount = isMost ? INT_MIN : INT_MAX;
    NSDictionary *freqCounts = [counts objectForKey:[NSString stringWithFormat:@"%d", i]];
    for (NSString *key in freqCounts) {
      int count = ((NSNumber *) [freqCounts objectForKey:key]).intValue;
      
      if (isMost ? count > selectionCount : count < selectionCount) {
        selectionCount = count;
        selection = key;
      }
    }
    
    [res appendString:selection];
  }
  
  return [NSString stringWithString:res];
}

int main() {
  @autoreleasepool {
    NSString *input = @"eedadn\ndrvtee\neandsr\nraavrd\natevrs\ntsrnev\nsdttsa\nrasrtv\nnssdts\nntnada\nsvetve\ntesnvt\nvntsnd\nvrdear\ndvrsen\nenarar";
    printf("%s\n", [solve(input, true) UTF8String]);
    printf("%s\n", [solve(input, false) UTF8String]);
  }
}
