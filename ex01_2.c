#include <stdio.h>

int main(void)
{
	int vx, vy;
	
	puts("二つの整数を入力してください．");
	printf(" 整数 vx: "); scanf("%d", &vx);
	printf(" 整数 vy: "); scanf("%d", &vy);
	
	printf("%d\n", vx+vy);
	printf("%d\n", vx-vy);
	printf("%d\n", vx*vy);
	printf("%d\n", vx/vy);
	printf("%d\n", vx%vy);
	
	return 0;
}

