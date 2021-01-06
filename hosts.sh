#!/bin/sh

die() {
    printf "$1\n" 2>&1
    exit 1
}

install() {
    if [[ $EUID -ne 0 ]]; then
        die "install must be run as root"
        exit 1
    fi
    mv /etc/hosts /etc/hosts.bak
    cp hosts /etc/hosts
}

gen() {
    SELECT="$(cat select)"
    rm -f hosts
    for i in $SELECT ; do
        f="$(find "$i" -type f -name hosts)"
        for j in $f ; do
            printf "adding $j\n"
            printf "# $j\n" >> hosts
            cat "$j" >> hosts
            printf "\n\n" >> hosts
        done
    done
}

update_base() {
    URLS="$(cat base/urls)"
    rm -f base/hosts
    for u in $URLS ; do
        printf "fetching $u...\n"
        printf "# $u\n" >> base/hosts
        wget "$u" -O - >> base/hosts 2>/dev/null || die "couldn't download from $u"
        printf "\n\n" >> base/hosts
    done
}

print_help() {
    printf "$0 [gen|update_base|install]\n"
}

case "$1" in
    "")
        update_base && gen && install
        ;;
    gen)
        gen
        ;;
    update_base)
        update_base
        ;;
    install)
        install
        ;;
    *)
        print_help
        ;;
esac
