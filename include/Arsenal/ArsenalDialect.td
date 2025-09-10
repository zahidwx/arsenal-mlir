#ifndef ARSENAL_DIALECT
#define ARSENAL_DIALECT

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// Arsenal dialect definition.
//===----------------------------------------------------------------------===//

def Arsenal_Dialect : Dialect {
    let name = "arsenal";
    let summary = "A arsenal out-of-tree MLIR dialect.";
    let description = [{
        This dialect is minimal example to implement arsenal-world kind of sample code
        for MLIR.
    }];
    let cppNamespace = "::arsenal";
}

//===----------------------------------------------------------------------===//
// Base arsenal operation definition.
//===----------------------------------------------------------------------===//

class Arsenal_Op<string mnemonic, list<Trait> traits = []> :
        Op<Arsenal_Dialect, mnemonic, traits>;

#endif // ARSENAL_DIALECT
