SRCDIR := tex
SRCEXT := tex

BUILDDIR := Sections

CHAPTER_SRC := $(shell find $(SRCDIR) -type f -name "*.$(SRCEXT)")
TEX_IN := $(patsubst $(SRCDIR)/%,$(SRCDIR)/%,$(CHAPTER_SRC:.$(SRCEXT)=.tex))
SECTION_OUT := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(CHAPTER_SRC:.$(SRCEXT)=.pdf))

summary.pdf: $(TEX_IN) main.tex
	pdflatex -jobname=summary main.tex

sections: $(SECTION_OUT)
	@echo "Chapter building complete"

$(BUILDDIR)/%.pdf: $(SRCDIR)/%.$(SRCEXT) main.tex
	@mkdir -p $(BUILDDIR)
	pdflatex -jobname=$(basename $@) "\includeonly{$(basename $<)}\input{main}"

clean:
	# We have to use "-f" so that we ignore errors if the files don't exist
	@rm *.aux *.log *.pdf -f
	@rm ./$(BUILDDIR)/*.aux -f
	@rm ./$(BUILDDIR)/*.log -f
	@rm ./$(BUILDDIR)/*.pdf -f
	@rm ./$(SRCDIR)/*.aux -f
	@rm ./$(SRCDIR)/*.log -f
	@rm ./$(SRCDIR)/*.pdf -f
