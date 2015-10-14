NAME=reg_file
TOP=alu_regfile

CC = iverilog
DEBUG = 
CFLAGS = $(DEBUG)

all: $(NAME) $(TOP)

$(NAME): $(NAME).v $(NAME)_tb.v
	$(CC) $(CFLAGS) $(NAME).v $(NAME)_tb.v -o $(NAME)

$(TOP): $(TOP).v $(TOP)_tb.v
	$(CC) $(CFLAGS) $(TOP).v reg_file.v mux.v eightbit_alu.v $(TOP)_tb.v -o $(TOP)

clean:
	rm $(NAME) $(TOP)
