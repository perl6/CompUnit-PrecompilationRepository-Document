use v6.c;

use Test;
use CompUnit::PrecompilationRepository::Document;
use File::Directory::Tree;
use nqp;

constant cache-name = "cache";
my $precomp-store = CompUnit::PrecompilationStore::File.new(prefix =>
        cache-name.IO );

for <simple sub/simple> -> $doc-name {
    my $precomp = CompUnit::PrecompilationRepository::Document.new(
            store => $precomp-store,
            doc-name => $doc-name );
    ok( $precomp.key, "Key precomputed");
    like( $precomp.key, /<[0..9 A..F]>+/, "Hexa key is correct");
    $precomp.precompile("t/doctest/$doc-name.pod6".IO,
        $precomp.key, :force );
    my $handle = $precomp.load($precomp.key)[0];
    my $precompiled-pod = nqp::atkey($handle.unit,'$=pod')[0];
    is-deeply $precompiled-pod, $=pod[0], "Load precompiled pod $doc-name";
}

rmtree(cache-name);
done-testing;

=begin pod

=TITLE Powerful cache

Perl6 is quite awesome.

=end pod
