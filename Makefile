R=R

check:
	${R} --silent --vanilla -e "devtools::check('.', build_args=\"--compact-vignettes='both'\")"

build:
	${R} --silent --vanilla -e "devtools::build('.', args=\"--compact-vignettes=\\\"both\\\"\")"

quickbuild:
	${R} --silent --vanilla -e "devtools::build('.', vignettes=FALSE)"

document:
	${R} --silent --vanilla -e "devtools::document('.')"

install: document
	${R} --silent --vanilla -e "devtools::install('.')"
