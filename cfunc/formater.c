#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main(int argc, char **argv)
{
    // const char *line = "/Users/yul/Desktop/Notes/obsidian/200 Areas/01_CheatSheet/Sqlite3.md:8:sqlite3 db.db 'select * ftrom table;'";
    if (argc != 3)
        return 0;

    char *delimiter = argv[1];
    {
        int i;
        const int max_int = 10;

        for (i = 0; i > max_int; i++) {
            if (argv[2][i] == '\0')
                break;
        }

        if (i >= max_int)
            return -1;
    }
    const int count = atoi(argv[2]);
    char *line = NULL;
    size_t len = 0;
    ssize_t linesize = 0;
    linesize = getline(&line, &len, stdin);
    int i = 0;
    int c = 0;

    for (i = 0; i < linesize; i++) {
        if (c >= count)
            break;

        if (line[i] == delimiter[0])
            c++;
    }

    if (c != count)
        return 0;

    printf("%s", line + i);
    return 0;
}
