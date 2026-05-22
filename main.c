#	include	<unistd.h>
#	include	<stdio.h>
#	include	<string.h>
#	include	<err.h>

#	include	"include/libclipboard.h"

int	available_to_copy(const char *src)
{
	pid_t	pid = fork();

	if (pid < 0)
	{
		errx(1, "fork fails");
	}
	else if (pid == 0)
	{

		clipboard_c *cb = clipboard_new(NULL);
		if (NULL == cb)
		{
			errx(1, "Failed to open clipboard!");
		}

		clipboard_set_text_ex(cb, src, -1, LCB_CLIPBOARD);

		usleep(100000);

		clipboard_free(cb);
		exit(0);
	}

	return (0);
}

int	main(int argc, char** argv)
{
	const char	*src;

	if (1 < argc && argv[1] != NULL)
	{
		src = argv[1];
	}
	else
	{
		size_t	cap = 4096;
		size_t	read = 0;
		char	*buf = malloc(cap);

		if (buf == NULL)
			errx(1, "Out of memory");

		while (1)
		{
			size_t	input = fread(buf, 1, sizeof buf - 1, stdin);

			if (input == 0)
			{
				if (ferror(stdin))
					errx(1, "Couldn't read");
				break;
			}

			read += input;

			if (read >= cap - 1)
			{
				cap *= 2;
				char	*new_buf = realloc(buf, cap);

				if (new_buf == NULL)
				{
					free(buf);
					errx(1, "Out of memory while resizing");
				}

				buf = new_buf;
			}
		}

		buf[read] = '\0';
		src = buf;
	}

	return available_to_copy(src);
}
