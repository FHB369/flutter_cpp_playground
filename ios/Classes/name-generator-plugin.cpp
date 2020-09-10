//
// Created by fhb36 on 10-Sep-20.
//

#include <stdint.h>
#include <string>
#include <cstring>

using namespace std;

extern "C" __attribute__((visibility("default"))) __attribute__((used))
char *generate_name(int32_t age) {
    string epic_names[10] = {"Arthur", "Beowulf", "Castor", "Davy", "Griffin", "Leander", "Odysseus", "Pollux", "Thor", "Zeus"};
    int index = age % 10;
    string name = epic_names[index] ;
    char *cstr = new char[name.length() + 1];
    strcpy(cstr, name.c_str());
    return cstr;
}