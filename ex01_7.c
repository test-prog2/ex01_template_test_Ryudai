#include <stdio.h>

int main(void)
{
	int x, y, z;
	
	printf("Input 2 numbers: ");
	scanf("%d%d", &x, &y);
	while (y != 0) {
		z = x % y;
		x = y;
		y = z;
	}
	printf("gcd is %d\n", x);
	
	return 0;
}