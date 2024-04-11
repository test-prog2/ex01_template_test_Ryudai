#include <stdio.h>

int main(void)
{
	int month;
	
	printf("何月ですか：");
	scanf("%d", &month);
	
	if(month >= 3 && month <= 5)
		printf("%d 月は春です．\n", month);
	else if(month >= 6 && month <= 8)
		printf("%d 月は夏です．\n", month);
	else if(month >= 9 && month <= 11)
		printf("%d 月は秋です．\n", month);
	else if(month == 12 || month == 1 || month == 2)
		printf("%d 月は冬です．\n", month);
	else
		printf("%d 月はありません．\n", month);
	
	return 0;
}

