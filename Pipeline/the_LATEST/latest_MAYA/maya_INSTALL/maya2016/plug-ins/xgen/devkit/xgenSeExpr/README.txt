This example shows how to create a custom SeExpr Function that has a notion of XGen.

SeExpr supports plugins by itself. 
You need to set the $SE_EXPR_PLUGINS environment variable to either a list of .so/.dll or list of paths separated by ';'.
If you specify a path, it looks for files with names matching the "*.so/*.dll".

The entry function is called at initialization, and it should call 
the function pointer argument 'defineFunc' to register each user defined expression function. 
void SeExprPluginInit( SeExprFunc::Define defineFunc );
void SeExprPluginInitV2(SeExprFunc::Define3 defineFunc );

void define(const char* name, SeExprFunc f);
void define3(const char* name, SeExprFunc f,const char* docString);

To implement your own SeExprFunc, you need to make a class that derives from SeExprFunc or SeExprFuncX.

We didn't have to expose another registration API to register an XGen Expression.
It's just the matter of casting the expr pointer to XgExpression, in the following way.
inline XgExpression* getXgExpr(const SeExprNode* node)
{
	return static_cast<const XgSeExpr*>(node->expr())->xgexpr();
}

We provide an expression function example that uses OpenImageIO to perform a texture lookup at the given uv location.
In order to build, you must compile your own OpenImageIO and set $OPENIMAGEIO_PATH to point it. 

