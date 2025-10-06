#include "mlir/IR/DialectRegistry.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllExtensions.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"

#include "Arsenal/ArsenalDialect.h"
#include "Arsenal/ArsenalPasses.h"

#include "mlir/Dialect/Transform/IR/TransformDialect.h"

int main(int argc, char **argv) {
  mlir::DialectRegistry registry;
  registry.insert<arsenal::ArsenalDialect>();
  registry.insert<mlir::transform::TransformDialect>();

  mlir::registerAllDialects(registry);
  mlir::registerAllExtensions(registry);
  mlir::registerAllPasses();

  return mlir::asMainReturnCode(
      mlir::MlirOptMain(argc, argv, "Arsenal Pass Driver", registry));
}
