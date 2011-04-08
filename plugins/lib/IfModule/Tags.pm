package IfModule::Tags;

use strict;

sub _hdlr_if_module {
    my ( $ctx, $args, $cond ) = @_;
    my $module = $args->{ module };
    $module =~ s!\s!!g;
    if ( $module ) {
        die  "Invalid module name " . $module if $module =~ /[^\w:]/;
        eval "require $module";
        if (! $@ ) {
            return 1;
        }
    }
    return 0;
}

sub _hdlr_if_component {
    my ( $ctx, $args, $cond ) = @_;
    my $component = $args->{ component };
    $component = $args->{ plugin } unless $component;
    if ( $component ) {
        my $plugin = MT->component( $component );
        return 1 if $plugin;
    }
    return 0;
}

1;