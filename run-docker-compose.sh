#!/bin/bash

EXPAND_FILES="http-thermostat/dot.env.docker irkit-wrapper/dot.env.docker homebridge/config.json"

source .env
export MYSQL_ROOT_PASSWORD

function expand_file {
    perl -pe '
        BEGIN { 
            open my $f, "<", ".env" or die;
            while (<$f>) {
                chomp;
                next unless /=/;
                my ($k, $v) = split /=/, $_, 2;
                $env{$k} = $v;
            }
        }

        while (my($k, $v) = each %env) {
            # printf STDERR "k=%s v=%s\n", $k, $v;
            s/\$\Q$k\E/$v/g;
        }
    ' $1
}

for i in $EXPAND_FILES; do
    expand_file $i > $i.expanded
done

docker-compose "$@"
