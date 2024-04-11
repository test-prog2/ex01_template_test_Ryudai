#include <stdio.h>

int main(void)
{
	int no;
	
	printf("整数を入力してください．\n");
	scanf("%d", &no);
	
	if(no == 0)
		puts("その数は 0 です．");
	else if(no > 0)
		puts("その数は 正 です．");
	else
		puts("その数は 負 です．");
	
	return 0;
}

