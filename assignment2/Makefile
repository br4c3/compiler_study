CC = gcc
LEX = flex
YACC = bison

TARGET = calc

all: $(TARGET)

$(TARGET): calc.tab.c lex.yy.c
	$(CC) calc.tab.c lex.yy.c -o $(TARGET) -lm

calc.tab.c calc.tab.h: calc.y
	$(YACC) -d calc.y

lex.yy.c: calc.l calc.tab.h
	$(LEX) calc.l

run: all
	./$(TARGET)

clean:
	rm -f $(TARGET) calc.tab.c calc.tab.h lex.yy.c output.txt