SHELL := /bin/bash
CLASSPATH := $(shell sh -c "find /usr/share/java -type l | tr '\n' ':'")


antlr:
	CLASSPATH=".:$(CLASSPATH)" antlr4 Solution.g4

javac: antlr
	CLASSPATH=".:$(CLASSPATH)" javac *.java

build: javac

run-gui: build
	CLASSPATH=".:$(CLASSPATH)" /usr/share/antlr4/grun Solution expr -gui

run: build
	CLASSPATH=".:$(CLASSPATH)" ./analyze_antlr.sh input
