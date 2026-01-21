# =================================================
# Makefile for cumulative thesis with build folder
# =================================================

TEX=pdflatex
BIB=biber
MAIN=main
BUILD=build

# Ensure build folder exists
$(BUILD):
	mkdir -p $(BUILD)

# -------------------------------------------------
# Default target: build PDF
# -------------------------------------------------
all: $(BUILD)/$(MAIN).pdf copy-pdf

# -------------------------------------------------
# Build PDF in build/
# -------------------------------------------------
$(BUILD)/$(MAIN).pdf: $(MAIN).tex $(shell find . -name '*.tex') $(shell find . -name '*.sty') | $(BUILD)
	# 1st LaTeX run
	$(TEX) -output-directory=$(BUILD) $(MAIN).tex
	# Generate glossary (if any)
	makeglossaries $(BUILD)/$(MAIN)
	# Bibliography
	$(BIB) $(BUILD)/$(MAIN)
	# 2nd LaTeX run
	$(TEX) -output-directory=$(BUILD) $(MAIN).tex
	# 3rd LaTeX run for cross-references
	$(TEX) -output-directory=$(BUILD) $(MAIN).tex

# -------------------------------------------------
# Copy PDF back to root folder automatically
# -------------------------------------------------
copy-pdf: $(BUILD)/$(MAIN).pdf
	cp $(BUILD)/$(MAIN).pdf ./$(MAIN).pdf

# -------------------------------------------------
# Clean only build artifacts
# -------------------------------------------------
clean:
	rm -rf $(BUILD)/*

# -------------------------------------------------
# Clean build artifacts + root PDF
# -------------------------------------------------
cleanall: clean
	rm -f $(MAIN).pdf

# -------------------------------------------------
# Phony targets
# -------------------------------------------------
.PHONY: all clean cleanall copy-pdf
