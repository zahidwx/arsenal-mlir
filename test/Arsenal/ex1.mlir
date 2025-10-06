module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(
       %arg0: !transform.any_op,
       %arg1: !transform.op<"linalg.matmul">,
       %arg2: !transform.op<"linalg.elementwise">) {
    // The actual tiling transformation takes tile sizes as attributes.
    %loop, %tiled = transform.structured.tile_using_forall %arg1
                    tile_sizes [4, 32]
      : (!transform.op<"linalg.matmul">)
     -> (!transform.any_op, !transform.any_op)
    transform.yield
    }

    func.func @fc_relu(%lhs: tensor<512x512xf32>, %rhs: tensor<512x512xf32>,
                    %bias: tensor<512x512xf32>, %output: tensor<512x512xf32>)
                    -> tensor<512x512xf32> {
    // Matrix-matrix multiplication.
    %matmul = linalg.matmul ins(%lhs, %rhs: tensor<512x512xf32>, tensor<512x512xf32>)
                            outs(%output: tensor<512x512xf32>) -> tensor<512x512xf32>

    // Elementwise addition.
    %biased = linalg.elementwise kind=#linalg.elementwise_kind<add>
        ins(%matmul, %bias : tensor<512x512xf32>, tensor<512x512xf32>)
        outs(%output : tensor<512x512xf32>) -> tensor<512x512xf32>

    // Elementwise max with 0 (ReLU).
    %c0f = arith.constant 0.0 : f32
    %relued = linalg.elementwise kind=#linalg.elementwise_kind<max_signed>
        indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> ()>, affine_map<(d0, d1) -> (d0, d1)>]
        ins(%biased, %c0f : tensor<512x512xf32>, f32)
        outs(%output : tensor<512x512xf32>) -> tensor<512x512xf32>
    func.return %relued : tensor<512x512xf32>
    }
}
