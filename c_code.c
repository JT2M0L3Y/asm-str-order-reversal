/**
 * C program to reverse order of words in a string
 */
#include <stdio.h>
#include <string.h>

int main()
{
    char str[20], reverse[20];
    int len, i, index, wordStart, wordEnd;

    printf("Enter any string: ");
    gets(str);

    len = strlen(str);
    index = 0;

    // Start checking of words from the end of string
    wordStart = len - 1;
    wordEnd   = len - 1;

    while(wordStart > 0)
    {
        // If a word is found
        if(str[wordStart] == ' ')
        {
            // Add the word to the reverse string
            i = wordStart + 1; //goes to first character of the word

            while(i <= wordEnd)
            {
                reverse[index] = str[i]; // adds the characters until the end of the given word

                i++;        //increments i and index in order to progress through the word
                index++;
            }
            reverse[index++] = ' '; // makes a space after the word 

            wordEnd = wordStart - 1; // goes back to the space before the initial word
        }

        wordStart--;    //decrements and then continues backwards through the given sentence
    }

    // Finally add the last word
    for(i=0; i<=wordEnd; i++)
    {
        reverse[index] = str[i]; //add the first word in str[] to the end of reverse because there will not be a space to detect
        index++;
    }

    // Add NULL character at the end of reverse string
    reverse[index] = '\0'; 

    printf("Original string \n%s\n\n", str);
    printf("Reverse ordered words \n%s", reverse);

    return 0;
}