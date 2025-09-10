add_mlir_dialect_library(MLIRArsenal
		ArsenalDialect.cpp
		ArsenalOps.cpp

        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/Arsenal

        DEPENDS
        MLIRArsenalOpsIncGen

	LINK_LIBS PUBLIC
	MLIRIR
	)
