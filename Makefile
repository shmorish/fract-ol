NAME = fractol

SRC_PATH = srcs
SRC = main.c \
	mandelbrot.c \
	julia.c \
	zoom.c \
	destroy_window.c \
	color.c \
	error_msg.c
SRCS = $(addprefix $(SRC_PATH)/, $(SRC))

OBJ_PATH = obj
OBJ = $(SRC:.c=.o)
OBJS = $(addprefix $(OBJ_PATH)/, $(OBJ))

INC_PATH = includes
INC = fractol.h
INCS = $(addprefix $(INC_PATH)/, $(INC))

LIB_PATH = libft
LIB = libft.a
LIBS = $(addprefix $(LIB_PATH)/, $(LIB))

MLX_PATH = minilibx
MLX = libmlx.a
MLXS = $(addprefix $(MLX_PATH)/, $(MLX))

CC = cc
CFLAGS = -Wall -Wextra -Werror

CHECK = \033[32m[✔]\033[0m
REMOVE = \033[31m[✘]\033[0m
BLUE = \033[1;34m
RESET = \033[0m

all: $(NAME)

$(NAME): $(LIBS) $(MLXS) $(OBJS)
	@ $(CC) $(CFLAGS) -o $(NAME) $(OBJS) $(LIBS) $(MLXS) -framework OpenGL -framework AppKit
	@echo "$(CHECK) $(BLUE)Compiling fractol... $(RESET)"
	@ chmod +x ./ascii
	@ ./ascii

$(LIBS):
	@ make -C $(LIB_PATH)

$(MLXS):
	@ make -C $(MLX_PATH)

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c $(INCS)
	@ mkdir -p $(OBJ_PATH)
	@ $(CC) $(CFLAGS) -o $@ -c $< -I $(INCS)

norm:
	norminette $(SRCS) $(INCS) $(LIB_PATH)

clean:
	@ make -C $(LIB_PATH) clean
	@ make -C $(MLX_PATH) clean
	@ rm -rf $(OBJ_PATH)
	@echo "$(REMOVE) $(BLUE)Remove object files... $(RESET)"

fclean: clean
	@ make -C $(LIB_PATH) fclean
	@ rm -rf $(NAME)
	@echo "$(REMOVE) $(BLUE)Remove fractol... $(RESET)"

re: fclean all

.PHONY: all norm clean fclean re