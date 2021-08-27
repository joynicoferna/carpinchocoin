#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

CARPINCHOD=${CARPINCHOD:-$BINDIR/carpinchod}
CARPINCHOCLI=${CARPINCHOCLI:-$BINDIR/carpincho-cli}
CARPINCHOTX=${CARPINCHOTX:-$BINDIR/carpincho-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/carpincho-wallet}
CARPINCHOQT=${CARPINCHOQT:-$BINDIR/qt/carpincho-qt}

[ ! -x $CARPINCHOD ] && echo "$CARPINCHOD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a CHOVER <<< "$($CARPINCHOCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for carpinchod if --version-string is not set,
# but has different outcomes for carpincho-qt and carpincho-cli.
echo "[COPYRIGHT]" > footer.h2m
$CARPINCHOD --version | sed -n '1!p' >> footer.h2m

for cmd in $CARPINCHOD $CARPINCHOCLI $CARPINCHOTX $WALLET_TOOL $CARPINCHOQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${CHOVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${CHOVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
