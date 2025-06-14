struct Uniforms {
    time : f32
};
@group(0) @binding(0) var<uniform> uniforms : Uniforms;

struct VertexOutput {
    @builtin(position) Position : vec4<f32>;
    @location(0) fragUV : vec2<f32>;
};

@vertex
fn vs_main(@builtin(vertex_index) vertexIndex : u32) -> VertexOutput {
    var pos = array<vec2<f32>, 6>(
        vec2<f32>(-1.0, -1.0),
        vec2<f32>( 1.0, -1.0),
        vec2<f32>(-1.0,  1.0),
        vec2<f32>(-1.0,  1.0),
        vec2<f32>( 1.0, -1.0),
        vec2<f32>( 1.0,  1.0)
    );
    var out: VertexOutput;
    out.Position = vec4<f32>(pos[vertexIndex], 0.0, 1.0);
    out.fragUV = (pos[vertexIndex] + vec2<f32>(1.0,1.0)) * 0.5;
    return out;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let wave = sin((in.fragUV.x + uniforms.time) * 10.0) * 0.05;
    let blue = 0.7 + wave;
    return vec4<f32>(0.0, 0.4, blue, 1.0);
}
