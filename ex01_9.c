#include <stdio.h>

int gcd(int x, int y);
int main(void)
{
	int x, y, result;
	
	printf("Input 2 numbers: ");
	scanf("%d%d", &x, &y);
	
	result = gcd(x, y);
	printf("gcd is %d\n", result);
	
	return 0;
}

int gcd(int x, int y)
{
	int z;
	
	while (y != 0) {
		z = x % y;
		x = y;
		y = z;
	}
	
	return x;
}
