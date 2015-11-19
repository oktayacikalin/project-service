# Makefile for generating the nginx conf files.

SOURCES=$(shell ls *.mustache)
OBJECTS=$(SOURCES:.mustache=.conf)

all: $(SOURCES) $(OBJECTS)

%.conf: %.yml %.mustache
	mustache $^ > $@

clean:
	rm $(OBJECTS)