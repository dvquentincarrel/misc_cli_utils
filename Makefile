export bash_setup_dir=$${HOME}/.config/bash/setup
bin_dir=$$HOME/.local/bin
clobber=i

install:
	-@mkdir -p $(bin_dir)
	-@ln -s -$(clobber) $$PWD/b64_time $(bin_dir)/b64_time
	-@ln -s -$(clobber) $$PWD/fmenu $(bin_dir)/fmenu
	-@ln -s -$(clobber) $$PWD/compact $(bin_dir)/compact
	-@ln -s -$(clobber) $$PWD/dense_roach $(bin_dir)/dense_roach
	-@ln -s -$(clobber) $$PWD/locale_toggle $(bin_dir)/locale_toggle
	-@ln -s -$(clobber) $$PWD/makemd $(bin_dir)/makemd
	-@ln -s -$(clobber) $$PWD/nice_name $(bin_dir)/nice_name
	-@ln -s -$(clobber) $$PWD/nundle $(bin_dir)/nundle
	-@ln -s -$(clobber) $$PWD/qwerty_popup $(bin_dir)/qwerty_popup
	-@ln -s -$(clobber) $$PWD/theft $(bin_dir)/theft
	-@ln -s -$(clobber) $$PWD/tui_light $(bin_dir)/tui_light
	-@ln -s -$(clobber) $$PWD/unb64_time $(bin_dir)/unb64_time
	-@ln -s -$(clobber) $$PWD/wedit $(bin_dir)/wedit
	-@ln -s -$(clobber) $$PWD/yt_pl_lost_and_found $(bin_dir)/yt_pl_lost_and_found
	-@ln -s -$(clobber) $$PWD/yt_pl_parse $(bin_dir)/
	-@ln -s -$(clobber) $$PWD/_feedback.bash $(bash_setup_dir)/999_feedback.bash
	-@ln -s -$(clobber) $$PWD/rrg $(HOME)/.local/bin/rrg
