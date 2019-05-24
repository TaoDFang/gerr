R=R

check:
	${R} --silent --vanilla -e "devtools::check('.')"

build:
	${R} --silent --vanilla -e "devtools::build('.')"

document:
	${R} --silent --vanilla -e "devtools::document('.')"

install: document
	${R} --silent --vanilla -e "devtools::install('.')"
