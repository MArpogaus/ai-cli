##    AI-CLI Simplifying AI Experiments
##    Copyright (C) 2022  Marcel Arpogaus, Julian Jandeleit
##
##    This program is free software: you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation, either version 3 of the License, or
##    (at your option) any later version.
##
##    This program is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##
##    You should have received a copy of the GNU General Public License
##    along with this program.  If not, see <https://www.gnu.org/licenses/>.
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "[36m%-30s[0m %s", $$1, $$2}'

install: ## install ai-cli
	dpkg-deb -b src
	dpkg -i src.deb || apt -f install 
	rm src.deb

uninstall: ## uninstall ai-cli
	dpkg -r ai-cli

check: ## run tests for ai-cli
	run-tests.sh
