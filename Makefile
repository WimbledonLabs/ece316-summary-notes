SRCDIR := tex
SRCEXT := tex

BUILDDIR := Sections

CHAPTER_SRC := $(shell find $(SRCDIR) -type f -name "*.$(SRCEXT)")
SECTION_OUT := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(CHAPTER_SRC:.$(SRCEXT)=.pdf))

all:
	pdflatex -jobname=summary main.tex

sections: $(SECTION_OUT)
	@echo "Chapter building complete"

$(BUILDDIR)/%.pdf: $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(BUILDDIR)
	pdflatex -jobname=$(basename $@) "\includeonly{$(basename $<)}\input{main}"
