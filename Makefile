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
# Default target: build PDF in build/ (for editing)
# -------------------------------------------------
all: $(BUILD)/$(MAIN).pdf

# -------------------------------------------------
# Build PDF in build/
# -------------------------------------------------
SOURCES := $(shell find . \( -name '*.tex' -o -name '*.sty' -o -name '*.bib' \) -not -path './$(BUILD)/*')

$(BUILD)/$(MAIN).pdf: $(SOURCES) | $(BUILD)
	$(TEX) -synctex=1 -interaction=nonstopmode -output-directory=$(BUILD) $(MAIN).tex
	makeglossaries -d $(BUILD) $(MAIN)
	$(BIB) $(BUILD)/$(MAIN)
	$(TEX) -synctex=1 -interaction=nonstopmode -output-directory=$(BUILD) $(MAIN).tex
	$(TEX) -synctex=1 -interaction=nonstopmode -output-directory=$(BUILD) $(MAIN).tex

# -------------------------------------------------
# Optional: export PDF for submission
# -------------------------------------------------
export: $(BUILD)/$(MAIN).pdf
	cp $(BUILD)/$(MAIN).pdf ./$(MAIN).pdf

# -------------------------------------------------
# Clean only build artifacts
# -------------------------------------------------
clean:
	rm -rf $(BUILD)/*

# -------------------------------------------------
# Clean build artifacts + exported root PDF
# -------------------------------------------------
cleanall: clean
	rm -f $(MAIN).pdf

# -------------------------------------------------
# Phony targets
# -------------------------------------------------
.PHONY: all clean cleanall export
