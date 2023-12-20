export bash_setup_dir=$${HOME}/.config/bash/setup

install:
	-@ln -s -f $$PWD/_feedback.bash $(bash_setup_dir)/999_feedback.bash
	-@ln -s -f $$PWD/rrg $(HOME)/.local/bin/rrg
