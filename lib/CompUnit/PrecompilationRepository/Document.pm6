use v6.*;
use nqp;
constant default-cache-dir = ".doc-cache";

class CompUnit::PrecompilationRepository::Document is CompUnit::PrecompilationRepository::Default {

    my $precomp-store;
    has Str $.doc-name;
    has IO::Path $.doc-path;
    has Str $!key;
    has $!precompiled-pod;
    has $!handle;

    #| Initializes the class variable that contains the precomp store
    sub init( $prefix = default-cache-dir ) is export {
        $precomp-store =
                CompUnit::PrecompilationStore::File.new(
                        prefix => $prefix.IO
                        );
    }

    #! Initializes object with a document path, will fail if it does not exist
    method new( $doc-path ) {
        init() unless $precomp-store;
        my $this-path = IO::Path.new( $doc-path );
        fail("Path $this-path not found") if ! $this-path.e;        my $doc-name = $this-path.basename;
        self.bless(
                doc-path => $this-path,
                doc-name => $doc-name,
                store => $precomp-store
                );
    }

    submethod TWEAK() {
        $!key = key-for( $!doc-name);
        self.precompile($!doc-path, $!key, :force );
        $!handle = self.load($!key)[0];
        $!precompiled-pod = nqp::atkey($!handle.unit,'$=pod')[0];
    }

    # Returns the cache key, mainly for testing purposes
    method key() {
        $!key
    }

    # Returns the precompiled pod
    method precompiled-pod() { $!precompiled-pod }

    #! Provides a key for the document with that particular name
    sub key-for( Str $doc-name --> Str ) is export {
        return nqp::sha1($doc-name);
    }

}
