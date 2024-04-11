#include <stdio.h>

int main(void)
{
	int month[] = { 0, 4, 4, 4, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 7};
	int day[] = { 0, 16, 23, 30, 14, 21, 28, 4, 11, 18, 25, 2, 9, 16, 23, 30};
	int i;
	
	for (i = 1; i <= 15; i++) {
		printf("プログラミング演習の第 %d 回は %d 月 %d 日です\n", i, month[i], day[i]);
	}
	return 0;
}
