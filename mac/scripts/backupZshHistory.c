#include <stdlib.h>
#include <stdio.h>
int main(void) {
    const char* home = getenv("HOME");
    char command[256];
    sprintf(command, "%s/scripts/backup_zsh_history.sh", home);
    int status = system(command);
    int ret = WEXITSTATUS(status);
    return ret;
}
