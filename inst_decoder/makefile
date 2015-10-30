NAME=inst_decoder

CC = iverilog
DEBUG = 
CFLAGS = $(DEBUG)

$(NAME): $(NAME).v $(NAME)_tb.v
	$(CC) $(CFLAGS) $(NAME).v $(NAME)_tb.v -o $(NAME)

clean:
	rm $(NAME)
