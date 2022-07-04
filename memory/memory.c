#include "memory.h"

Slot *createSlot(char* lex_val, int val) {
    Slot *slot = malloc(sizeof(Slot));
    slot->next = NULL;
    slot->id = lex_val;
    slot->val = val;

    return slot;
}

Memory *createMemory() {
    Memory *m = malloc(sizeof(Memory));
    m->head = NULL;

    return m;
}

int isEmpty(Memory *m) {
    return m == NULL || m->head == NULL;
}

void printMemory(Memory *m) {
    Slot *aux;

    if (!isEmpty(m)) {
        aux = m->head;

        while (aux != NULL) {
            printf("%s = %d\t", aux->id, aux->val);
            aux = aux->next;
        }
    }
}

int getID(Memory *m, char *lex_val) {
    Slot *aux;

    if(!isEmpty(m)){
        aux = m->head;

        while(aux != NULL) {
            if(strcmp(aux->id, lex_val) == 0) {
                return aux->val;
            }
            aux = aux->next;
        }
    } 

    return -1;
}

int assignID(Memory *m, char *lex_val, int val) {
    Slot *aux;
    
    // Caso 1: memória está vazia
    if (isEmpty(m)) {
       m->head = createSlot(lex_val, val);
       return 1;
    } else {
        aux = m->head;

        while (aux->next != NULL) {
            // Caso 2: Reatribuição de varáveis x := x + y; 
            if(strcmp(aux->id, lex_val) == 0) {
                aux->val = val;
                return 1;
            }
            aux = aux->next;
        }
        
        if(strcmp(aux->id, lex_val) == 0) {
            aux->val = val;
            return 1;
        }

        // Caso 3: Atribuição de uma nova variável a memória
        aux->next = createSlot(lex_val, val);
        return 1;
    }

    return 0;
}

void clearMemory(Memory *m) {
    Slot *aux;
    
    if(m != NULL){
        while(!isEmpty(m)) {
            aux = m->head;
            m->head = m->head->next;
            free(aux);
        }

        free(m);
    }
}