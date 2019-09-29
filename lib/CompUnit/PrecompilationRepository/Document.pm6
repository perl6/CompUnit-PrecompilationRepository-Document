use v6.*;
use nqp;

class CompUnit::PrecompilationRepository::Document is CompUnit::PrecompilationRepository::Default {

    #! Provides a key for the document with that particular name
    sub key-for( Str $doc-name --> Str ) is export {
        nqp::sha1($doc-name);
    }

}
