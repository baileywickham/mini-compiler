# Should really move to something else to manage the build.

# Provided code assumes at least Java 8
JAVAC=javac
JAVA=java
JAR=jar
ANTLRJAR=antlr-4.8-complete.jar
JSONJAR=javax.json-1.0.4.jar

CLASSPATH_MOD=$(ANTLRJAR):$(JSONJAR)

FILES=MiniCompiler.java MiniToJsonVisitor.java MiniToAstDeclarationsVisitor.java MiniToAstExpressionVisitor.java MiniToAstFunctionVisitor.java MiniToAstProgramVisitor.java MiniToAstStatementVisitor.java MiniToAstTypeDeclarationVisitor.java MiniToAstTypeVisitor.java

GENERATED=MiniBaseVisitor.java MiniLexer.java MiniLexer.tokens Mini.tokens MiniVisitor.java MiniParser.java MiniBaseListener.java MiniListener.java

all : MiniCompiler.jar

MiniCompiler.jar : MiniCompiler.class
	mkdir -p build
	$(JAR) xf $(ANTLRJAR) org
	$(JAR) xf $(JSONJAR) org javax
	mv org build/
	mv javax build/
	$(JAR) -cfm MiniCompiler.jar manifest.mf -C ./build/ .

MiniCompiler.class : antlr.generated ${FILES}
	mkdir -p build
	$(JAVAC) -d build -cp ${CLASSPATH}:$(CLASSPATH_MOD) *.java ast/*.java

antlr.generated : Mini.g4
	$(JAVA) -cp ${CLASSPATH}:$(CLASSPATH_MOD) org.antlr.v4.Tool -visitor Mini.g4
	touch antlr.generated

clean:
	\rm -rf *generated* ${GENERATED} build/*.class build/ast/*.class MiniCompiler.jar
