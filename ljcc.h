#define _POSIX_C_SOURCE 200809L
#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <stdint.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct Type Type;
typedef struct Node Node;
typedef struct Member Member;

//
//strings.c
//

char* format(char* fmt, ...);



typedef enum {
    TK_IDENT,
    TK_PUNCT,
    TK_KEYWORD,
    TK_STR,
    TK_NUM,
    TK_EOF,
} TokenKind;

typedef struct Token Token;

struct Token {
    TokenKind kind;
    Token* next;
    int64_t val;
    char* loc;
    int len;

    Type* ty;
    char* str;

    int line_no;
};

void error(char *fmt, ...);
void error_at(char* loc, char* fmt, ...);
void error_tok(Token* tok, char* fmt, ...);
bool equal(Token* tok, char* op);
Token* skip(Token* tok, char* op);
bool consume(Token** rest, Token* tok, char* str);
Token* tokenize_file(char* filename);


#define unreachable() \
  error("internal error at: %s:%d", __FILE__, __LINE__)

//
// parse.c
//

typedef struct Obj Obj;
struct Obj {
    Obj *next;
    char *name;
    Type* ty;

    bool is_local;
    int offset;
    bool is_function;
    bool is_definition;

    Obj* params;
    Node* body;
    Obj* locals;
    int stack_size;

    char* init_data;
};

typedef enum{
    ND_ADD, 
    ND_SUB,
    ND_MUL,
    ND_DIV,
    ND_NEG,
    ND_EQ,
    ND_VAR,
    ND_NE,
    ND_LT,
    ND_LE,
    ND_ASSIGN,
    ND_ADDR,
    ND_DEREF,
    ND_COMMA,
    ND_MEMBER,
    ND_RETURN,
    ND_IF,
    ND_FOR,// "for" or "swhile"
    ND_BLOCK,
    ND_FUNCALL,
    ND_EXPR_STMT,
    ND_STMT_EXPR,
    ND_NUM,
} NodeKind;


struct Node {
    NodeKind kind;
    Node* next;
    Type* ty;
    Token* tok;

    Node *lhs;
    Node *rhs;

//  "if" statement
    Node* cond;
    Node* then;
    Node* els;

    Node* init;
    Node* inc;

    Node *body;

    Member* member;

    char* funcname;
    Node* args;

    Obj* var;
    int64_t val;
};

typedef enum {
    TY_VOID,
    TY_CHAR,
    TY_SHORT,
    TY_INT,
    TY_LONG,
    TY_PTR,
    TY_FUNC,
    TY_ARRAY,
    TY_STRUCT,
    TY_UNION,
} TypeKind;


struct Type{
    TypeKind kind;
    int size;
    int align;

  // Pointer-to or array-of type. We intentionally use the same member
  // to represent pointer/array duality in C.
  //
  // In many contexts in which a pointer is expected, we examine this
  // member instead of "kind" member to determine whether a type is a
  // pointer or not. That means in many contexts "array of T" is
  // naturally handled as if it were "pointer to T", as required by
  // the C spec.

    Type* base;
    Token* name;

    int array_len;
    Member *members;
    Type* return_ty;
    Type* params;
    Type* next;
};


struct Member
{
    Member* next;
    Type* ty;
    Token* name;
    int offset;
};

extern Type* ty_void;
extern Type* ty_char;
extern Type* ty_int;
extern Type* ty_long;
extern Type* ty_short;


bool is_integer(Type* ty);
Type* copy_type(Type* ty);
Type* func_type(Type* return_ty);
Type* pointer_to(Type* base);
void add_type(Node* node);
Type* array_of(Type* base, int size);



void codegen(Obj* prog, FILE* out);
int align_to(int n, int align);
Obj *parse(Token* tok);
