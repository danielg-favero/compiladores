#include "./countCharacter.h"

int countCharacter(char *text, char character){
    int count = 0;

    for(int i = 0; text[i] != '\0'; i++){
        if(text[i] == character){
            count++;
        }
    }

    return count;
}