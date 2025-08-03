
##### Variables #####
SVGs := $(shell find . -type f -name "*.svg" -not -path "./sources/*" | sort)
# $(info SVGs: $(SVGs))

SIGHTS := $(SVGs:.svg=.png)

CARDS := $(foreach s,$(SVGs),\
            $(foreach i,1 2 3 4,\
                $(subst .svg,_card_$(i).png,$(s))))


##### Generic targets #####
all: sights cards galleries
sights: $(SIGHTS)
cards: $(CARDS)
galleries: gallery_cards.png gallery_sights.png

.PHONY: clean
clean:
	rm -f $(SIGHTS)
	rm -f $(CARDS)
	rm gallery_cards.png gallery_sights.png


#### Galleries #####
gallery_sights.png: $(SIGHTS)
	montage -label '%[Title]\n© %[Author] — %[Creation Time] — %[Copyright]' $(SIGHTS) -title "Hanafuda by nojhan" -geometry 1024 -borderwidth 20 -frame 7 -shadow -tile 1x $@

gallery_cards.png: $(CARDS)
	montage $(CARDS) -title "Hanafuda by nojhan" -geometry  256 -borderwidth 10 -frame 4 -mattecolor black -shadow -tile 4x $@


##### Sights #####
define sight_template =
$(1:.svg=.png): $(1)
	inkscape --without-gui --export-width=1024 --export-area-page --export-png=$(1:.svg=.png) $(1)
endef

$(foreach s,$(SVGs),\
    $(eval $(call sight_template,$(s)))\
)


##### Cards #####
define card_template =
$(1:.svg=_card_$(2).png): $(1)
	inkscape --without-gui --export-height=800 --export-id=card_$(i) --export-png=$(1:.svg=_card_$(2).png) $(1)
endef

$(foreach s,$(SVGs),\
    $(foreach i,1 2 3 4,\
        $(eval $(call card_template,$(s),$(i)))\
    )\
)

