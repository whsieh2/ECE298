/*---------------------------------------------------------------------------
  --      hello_world.c                                                    --
  --      Christine Chen                                                   --
  --      Fall 2013                                                        --
  --                                                                       --
  --      For use with ECE 298 Experiment 9                                --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------*/

#include <stdio.h>

#define to_hw_port (volatile char*) 0x00000070 // actual address here
#define to_hw_sig (volatile char*) 0x00000060 // actual address here
#define to_sw_port (char*) 0x00000050 // actual address here
#define to_sw_sig (char*) 0x00000040 // actual address here

char charToHex(char c)
{
	char hex = c;

	if (hex >= '0' && hex <= '9')
		hex -= '0';
	else if (hex >= 'A' && hex <='F')
	{
		hex -= 'A';
		hex += 10;
	}
	else if (hex >= 'a' && hex <='f')
	{
		hex -= 'a';
		hex += 10;
	}
	return hex;
}

char charsToHex(char c1, char c2)
{
	char hex1 = charToHex(c1);
	char hex2 = charToHex(c2);
	return (hex1 << 4) + hex2;
}

int main()
{
	int i;
	char str[32];
	//char c;

	*to_hw_sig = 0;
	*to_hw_port = 0;
	printf("Press reset!\n");
	while (*to_sw_sig != 3);
	int count = 0;
	while (1)
	{
		*to_hw_sig = 0;
		printf("\n");

		printf("Enter message:\n");
		scanf("%s", str);
		printf("\nTransmitting message...\n");

		for (i = 0; i < 32; i+=2)
		{
			*to_hw_sig = 1;
			*to_hw_port = charsToHex(str[i], str[i+1]);
			while (*to_sw_sig != 1);
			*to_hw_sig = 2;
			while (*to_sw_sig != 0);
		}
		*to_hw_sig = 0;
		printf("\n\n");

		printf("Enter key:\n");
		scanf("%s", str);


		printf("\nTransmitting key...\n");
		for (i = 0; i < 32; i+=2)
		{
			*to_hw_sig = 2;

			*to_hw_port = charsToHex(str[i], str[i+1]);

			while (*to_sw_sig != 1);
			*to_hw_sig = 1;
			while (*to_sw_sig != 0);
		}
		printf("finished the for");
		*to_hw_sig = 3;

		// TODO

		printf("\n\n");

		while (*to_sw_sig != 2);
		printf("Retrieving message...\n");
		for (i = 0; i < 16; ++i)
		{
			*to_hw_sig = 1;
			while (*to_sw_sig != 1);
			str[i] = *to_sw_port;
			*to_hw_sig = 2;
			while (*to_sw_sig != 0);
		}

		printf("\n\n");

	printf("Decoded message:\n");

		// TODO
		for(i = 0; i<16;++i)
		{
			printf("%02x",0xff & str[i]);
		}




	}
	return 0;

}
