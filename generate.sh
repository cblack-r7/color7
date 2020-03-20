#!/bin/sh

e_error() {
	printf "%s\\n" "$1" >&2
	[ -n "$2" ] && exit "$2"
}

list_variants() {
	printf "style:\\n\\tvariant: description\\n"
	for s in $(find "./styles/" -type d); do
		if [ -f "$s/init.sh" ]; then
			STYLENAME=
			STYLEINFO=
			# shellcheck disable=SC1090
			. "$s/init.sh"
			[ -z "$STYLENAME" ] && e_error "Style name not set for $i!" 3
			[ -z "$STYLEINFO" ] && e_error "Style info not set for $i!" 3
			printf "%s:\\n" "$STYLENAME"
			for i in $(find "$s" -type f); do
				if [ "$(basename "$i")" = "init.sh" ]; then
					continue
				fi
				VARIANTNAME=
				VARIANTINFO=
				# shellcheck disable=SC1090
				. "$i"
				[ -z "$VARIANTNAME" ] && e_error "Name not set for $i!" 3
				[ -z "$VARIANTINFO" ] && e_error "Info not set for $i!" 3
				printf "\t%s: %s\\n" "$VARIANTNAME" "$VARIANTINFO"
			done
		fi
	done
}

check_vars() {
	[ -z "$FOREGROUND" ] && e_error "\$FOREGROUND not set! Exiting..." 1
	[ -z "$BACKGROUND" ] && e_error "\$BACKGROUND not set! Exiting..." 1
	[ -z "$CURSOR" ] && e_error "\$CURSOR not set! Exiting..." 1
	[ -z "$BLACK1" ] && e_error "\$BLACK1 not set! Exiting..." 1
	[ -z "$BLACK2" ] && e_error "\$BLACK2 not set! Exiting..." 1
	[ -z "$RED1" ] && e_error "\$RED1 not set! Exiting..." 1
	[ -z "$RED2" ] && e_error "\$RED2 not set! Exiting..." 1
	[ -z "$GREEN1" ] && e_error "\$GREEN1 not set! Exiting..." 1
	[ -z "$GREEN2" ] && e_error "\$GREEN2 not set! Exiting..." 1
	[ -z "$YELLOW1" ] && e_error "\$YELLOW1 not set! Exiting..." 1
	[ -z "$YELLOW2" ] && e_error "\$YELLOW2 not set! Exiting..." 1
	[ -z "$BLUE1" ] && e_error "\$BLUE1 not set! Exiting..." 1
	[ -z "$BLUE2" ] && e_error "\$BLUE2 not set! Exiting..." 1
	[ -z "$MAGENTA1" ] && e_error "\$MAGENTA1 not set! Exiting..." 1
	[ -z "$MAGENTA2" ] && e_error "\$MAGENTA2 not set! Exiting..." 1
	[ -z "$CYAN1" ] && e_error "\$CYAN1 not set! Exiting..." 1
	[ -z "$CYAN2" ] && e_error "\$CYAN2 not set! Exiting..." 1
	[ -z "$WHITE1" ] && e_error "\$WHITE1 not set! Exiting..." 1
	[ -z "$WHITE2" ] && e_error "\$WHITE2 not set! Exiting..." 1
	#[ -z "${}" ] && e_error "\${} not set! Exiting..." 1
}

render_template() {
	sed -e "s%{{.FOREGROUND}}%${FOREGROUND}%g" \
	    -e "s%{{.BACKGROUND}}%${BACKGROUND}%g" \
	    -e "s%{{.CURSOR}}%${CURSOR}%g" \
	    -e "s%{{.BLACK1}}%${BLACK1}%g" \
	    -e "s%{{.BLACK2}}%${BLACK2}%g" \
	    -e "s%{{.RED1}}%${RED1}%g" \
	    -e "s%{{.RED2}}%${RED2}%g" \
	    -e "s%{{.GREEN1}}%${GREEN1}%g" \
	    -e "s%{{.GREEN2}}%${GREEN2}%g" \
	    -e "s%{{.YELLOW1}}%${YELLOW1}%g" \
	    -e "s%{{.YELLOW2}}%${YELLOW2}%g" \
	    -e "s%{{.BLUE1}}%${BLUE1}%g" \
	    -e "s%{{.BLUE2}}%${BLUE2}%g" \
	    -e "s%{{.MAGENTA1}}%${MAGENTA1}%g" \
	    -e "s%{{.MAGENTA2}}%${MAGENTA2}%g" \
	    -e "s%{{.CYAN1}}%${CYAN1}%g" \
	    -e "s%{{.CYAN2}}%${CYAN2}%g" \
	    -e "s%{{.WHITE1}}%${WHITE1}%g" \
	    -e "s%{{.WHITE2}}%${WHITE2}%g" \
	    -e "s%{{.VARIANTNAME}}%${VARIANTNAME}%g" \
	    "$1" > "${2}.${3}"

}

generate() {
	[ -d "$2" ] || ( mkdir -p "$2" || e_error "Could not create output dir" 9 )
	for term in $(find "./templates/" -type d); do
		if [ -f "$term/init.sh" ]; then
			INTARGET=
			EXTENSION=
			# shellcheck disable=SC1090
			. "$term/init.sh"
			[ -z "$INTARGET" ] && e_error "Could not read template from $term" 4
			[ -z "$EXTENSION" ] && e_error "Extension was not set for $term" 4
                	#[ ! -z "$TEMPLATEXFRM" ] && printf "xform enabled\n"
			if [ "x$TEMPLATEXFRM" != "x" ]; then
						FOREGROUND="$($TEMPLATEXFRM "$FOREGROUND")"
						BACKGROUND="$($TEMPLATEXFRM "$BACKGROUND")"
						CURSOR="$($TEMPLATEXFRM "$CURSOR")"
						BLACK1="$($TEMPLATEXFRM "$BLACK1")"
						BLACK2="$($TEMPLATEXFRM "$BLACK2")"
						RED1="$($TEMPLATEXFRM "$RED1")"
						RED2="$($TEMPLATEXFRM "$RED2")"
						GREEN1="$($TEMPLATEXFRM "$GREEN1")"
						GREEN2="$($TEMPLATEXFRM "$GREEN2")"
						YELLOW1="$($TEMPLATEXFRM "$YELLOW1")"
						YELLOW2="$($TEMPLATEXFRM "$YELLOW2")"
						BLUE1="$($TEMPLATEXFRM "$BLUE1")"
						BLUE2="$($TEMPLATEXFRM "$BLUE2")"
						MAGENTA1="$($TEMPLATEXFRM "$MAGENTA1")"
						MAGENTA2="$($TEMPLATEXFRM "$MAGENTA2")"
						CYAN1="$($TEMPLATEXFRM "$CYAN1")"
						CYAN2="$($TEMPLATEXFRM "$CYAN2")"
						WHITE1="$($TEMPLATEXFRM "$WHITE1")"
						WHITE2="$($TEMPLATEXFRM "$WHITE2")"
			fi
			TERMNAME="$(basename "$term")"
			[ -d "$2/$TERMNAME" ] || ( mkdir -p "$2/$TERMNAME" || e_error "Could not create output dir" 9 )
			render_template "$term/$INTARGET" "$2/$TERMNAME/$VARIANTNAME" "$EXTENSION"
			#reset the template after xform
			# shellcheck disable=SC1090
			. "$1"
		fi
	done
}

sval="color7"
bval="all"
lflag=
oval="output"
while getopts s:lb:o: name
do
    case $name in
    s)    sval="$OPTARG";;
    b)    bval="$OPTARG";;
    o)	  oval="$OPTARG";;
    l)    lflag=1;;
    ?)    printf "Usage: %s: [-s style] [-b variant|all] [-o outputdir] [-l] args\\n-s: specify a style (defaults to 'color7')\\n-b: specify a variant (default generates all)\\n-o: output to directory, defaults to './output/'\\n-l: list variants\\n" "$0"
          exit 2;;
    esac
done

if [ -n "$lflag" ]; then
	list_variants
	exit 0
fi
shift $((OPTIND - 1))

for s in $(find "./styles/" -type d); do
        if [ -f "$s/init.sh" ]; then
                STYLENAME=
                STYLEINFO=
		# shellcheck disable=SC1090
                . "$s/init.sh"
                [ -z "$STYLENAME" ] && e_error "Style name not set for $i!" 3
                [ -z "$STYLEINFO" ] && e_error "Style info not set for $i!" 3
		if [ "x$STYLENAME" = "x$sval" ]; then
			for i in $(find "$s" -type f); do
                	        if [ "$(basename "$i")" = "init.sh" ]; then
                	                continue
                	        fi
                	        VARIANTNAME=
                	        VARIANTINFO=
				# shellcheck disable=SC1090
                	        . "$i"
                	        [ -z "$VARIANTNAME" ] && e_error "Name not set for $i!" 3
                	        [ -z "$VARIANTINFO" ] && e_error "Info not set for $i!" 3
				if [ "x$VARIANTNAME" = "x$bval" ]; then
					check_vars
					printf "generating %s style and the %s variant\\n" "$STYLENAME" "$VARIANTNAME"
					generate "$i" "$oval"
					
				fi
				if [ "xall" = "x$bval" ]; then
					check_vars
					printf "generating %s style and the %s variant\\n" "$STYLENAME" "$VARIANTNAME"
					generate "$i" "$oval"
				fi
                	done
			exit 0
		fi
        fi
done

e_error "Could not find variant and/or style!" 5
