use v6.*;
use nqp;

class CompUnit::PrecompilationRepository::Document is CompUnit::PrecompilationRepository::Default {
    
#    method !load-handle-for-path(CompUnit::PrecompilationUnit $unit) {
#            my $preserve_global := nqp::ifnull(nqp::gethllsym('perl6', 'GLOBAL'), Mu);
#            say $preserve_global;
#            if $*RAKUDO_MODULE_DEBUG -> $RMD { $RMD("Loading precompiled\n$unit") }
#            my $handle := CompUnit::Loader.load-precompilation-file($unit.bytecode-handle);
#            $unit.close;
#            nqp::bindhllsym('perl6', 'GLOBAL', $preserve_global);
#            CATCH {
#                default {
#                    nqp::bindhllsym('perl6', 'GLOBAL', $preserve_global);
#                    .throw;
#                }
#            }
#            $handle
#        }
#


    #! Provides a key for the document with that particular name
    sub key-for( Str $doc-name --> Str ) is export {
        nqp::sha1($doc-name);
    }

}
