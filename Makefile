subdirs := $(wildcard */)
sources := $(wildcard $(addsuffix *.v,$(subdirs)))

json := $(sources:%.v=%.json)
txt := $(sources:%.v=%.txt)

all: $(txt)

%.txt: %.json
	gp4par $< -o $@ -L $*.par
	
%.json: %.v
	yosys -o $@ -L $*.yrp -p "synth_greenpak4 -top top -part SLG46620V;" $<
	
clean: 
	rm -rf $(json) $(txt)
	
