printf "          "
for b in 0 1 2 3 4 5 6 7; do printf "  4${b}m "; done
printf "\n"
for f in "" 30 31 32 33 34 35 36 37; do
    for s in "" "1;"; do
        printf "%4sm" "${s}${f}"
        printf " \033[%sm%s\033[0m" "$s$f" "✗✗✗ "
        for b in 0 1 2 3 4 5 6 7; do
            printf " \033[4%s;%sm%s\033[0m" "$b" "$s$f" " ✗✗✗ "
        done
        echo
     done
done
