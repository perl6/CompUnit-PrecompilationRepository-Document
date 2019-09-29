use v6.c;

use Test;
use CompUnit::PrecompilationRepository::Document;
use File::Directory::Tree;

constant cache-name = "cache";
init( cache-name );

for <simple sub/simple> -> $doc-name {
    my $precomp =
            CompUnit::PrecompilationRepository::Document.new(
                    "t/doctest/$doc-name.pod6");
    ok( $precomp.key, "Key precomputed");
    like( $precomp.key, /<[0..9 A..F]>+/, "Hexa key is correct");
    is-deeply $precomp.precompiled-pod, $=pod[0], "Load precompiled pod
$doc-name";
}

rmtree(cache-name);
done-testing;

=begin pod

=TITLE Powerful cache

Perl6 is quite awesome.

=end pod
