#include <stdio.h>

int main(void)
{
	char name[48];
	
	printf(" お名前は：");
	scanf("%s", name);
	
	printf("こんにちは， %s さん．\n", name);
	
	return 0;
}
