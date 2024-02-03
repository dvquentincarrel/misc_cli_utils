export bash_setup_dir=$${HOME}/.config/bash/setup
bin_dir=$$HOME/.local/bin
clobber=i

install:
	-@mkdir -p $(bin_dir)
	-@ln -Ts -$(clobber) $$PWD/b64_time $(bin_dir)/b64_time
	-@ln -Ts -$(clobber) $$PWD/fmenu $(bin_dir)/fmenu
	-@ln -Ts -$(clobber) $$PWD/compact $(bin_dir)/compact
	-@ln -Ts -$(clobber) $$PWD/dense_roach $(bin_dir)/dense_roach
	-@ln -Ts -$(clobber) $$PWD/locale_toggle $(bin_dir)/locale_toggle
	-@ln -Ts -$(clobber) $$PWD/makemd $(bin_dir)/makemd
	-@ln -Ts -$(clobber) $$PWD/nice_name $(bin_dir)/nice_name
	-@ln -Ts -$(clobber) $$PWD/nundle $(bin_dir)/nundle
	-@ln -Ts -$(clobber) $$PWD/qwerty_popup $(bin_dir)/qwerty_popup
	-@ln -Ts -$(clobber) $$PWD/theft $(bin_dir)/theft
	-@ln -Ts -$(clobber) $$PWD/tui_light $(bin_dir)/tui_light
	-@ln -Ts -$(clobber) $$PWD/unb64_time $(bin_dir)/unb64_time
	-@ln -Ts -$(clobber) $$PWD/wedit $(bin_dir)/wedit
	-@ln -Ts -$(clobber) $$PWD/yt_pl_lost_and_found $(bin_dir)/yt_pl_lost_and_found
	-@ln -Ts -$(clobber) $$PWD/yt_pl_parse $(bin_dir)/
	-@ln -Ts -$(clobber) $$PWD/_feedback.bash $(bash_setup_dir)/999_feedback.bash
	-@ln -Ts -$(clobber) $$PWD/rrg $(HOME)/.local/bin/rrg
	-@ln -Ts -$(clobber) $$PWD/shorten_path $(HOME)/.local/bin/shorten_path
