# Extend common helper methods from Trixi.jl

# Ref: `get_node_vars(u, equations, solver::DG, indices...)` in Trixi.jl
@inline function get_node_vars(u, equations, indices...)
    SVector(ntuple(@inline(v->u[v, indices...]), Val(nvariables(equations))))
end

# Ref: `get_node_coords(x, equations, solver::DG, indices...)` in Trixi.jl
@inline function get_node_coords(x, equations, indices...)
    SVector(ntuple(@inline(idx->x[idx, indices...]), Val(ndims(equations))))
end

# Ref: `get_surface_node_vars(u, equations, solver::DG, indices...)` in Trixi.jl
@inline function get_surface_node_vars(u, equations, indices...)
    u_ll = SVector(ntuple(@inline(v->u[1, v, indices...]), Val(nvariables(equations))))
    u_rr = SVector(ntuple(@inline(v->u[2, v, indices...]), Val(nvariables(equations))))

    return u_ll, u_rr
end
