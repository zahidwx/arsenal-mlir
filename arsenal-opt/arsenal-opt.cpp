#include "mlir/IR/DialectRegistry.h"
#include "mlir/InitAllDialects.h"

#include "mlir/InitAllPasses.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"

#include "Arsenal/ArsenalDialect.h"
#include "Arsenal/ArsenalPasses.h"

int main(int argc, char **argv) {
  mlir::DialectRegistry registry;
  registry.insert<arsenal::ArsenalDialect>();

  mlir::registerAllDialects(registry);
  mlir::registerAllPasses();

  return mlir::asMainReturnCode(
      mlir::MlirOptMain(argc, argv, "Arsenal Pass Driver", registry));
}
