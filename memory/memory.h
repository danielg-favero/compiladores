#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Slot Slot;
typedef struct Memory Memory;

struct Slot {
    int val;
    char* id;
    Slot *next;
};

struct Memory {
    Slot *head;
};

Slot *creatSlot(char* lex_val, int val);
Memory *createMemory(void);
int isEmpty(Memory *l);
void inserSlot(Memory *l, char* lex_val, int val);
void printMemory(Memory *l);
int assignID(Memory *m, char *lex_val, int val);
int getID(Memory *l, char *lex_val);