module SheafCohomology

using LinearAlgebra
using Statistics

# =========================
# 1. Section embedding
# =========================

function embed_text(t::String)
    v = Float64.(collect(codeunits(t)))
    return [mean(v), std(v)]
end

function embed_section(texts::Vector{String})
    if isempty(texts)
        return zeros(2)
    end
    return mean(reduce(hcat, [embed_text(t) for t in texts]), dims=2)[:]
end

# =========================
# 2. Build sections
# =========================

function build_sections(clusters, all_texts)
    sections = Dict{Int, Vector{String}}()
    for (i, idxs) in enumerate(clusters)
        sections[i] = [all_texts[j] for j in idxs]
    end
    return sections
end

# =========================
# 3. Overlaps
# =========================

function build_overlaps(clusters)
    overlaps = Dict{Tuple{Int,Int}, Vector{Int}}()
    for i in 1:length(clusters), j in i+1:length(clusters)
        inter = intersect(clusters[i], clusters[j])
        if !isempty(inter)
            overlaps[(i,j)] = inter
        end
    end
    return overlaps
end

# =========================
# 4. Coboundary δ^0
# =========================

function coboundary_0(sections, overlaps, all_texts)

    edge_values = Dict()

    for ((i,j), idxs) in overlaps

        s_i = embed_section(sections[i])
        s_j = embed_section(sections[j])

        # restriction ≈ projection on overlap
        overlap_texts = [all_texts[k] for k in idxs]
        proj = embed_section(overlap_texts)

        # δ^0 = difference in overlap
        val = (s_i - proj) - (s_j - proj)

        edge_values[(i,j)] = val
    end

    return edge_values
end

# =========================
# 5. H^0 (global consistency)
# =========================

function compute_H0(sections, overlaps, all_texts; tol=1e-3)

    δ = coboundary_0(sections, overlaps, all_texts)

    # 全てゼロなら整合
    return all(norm(v) < tol for v in values(δ))
end

# =========================
# 6. H^1 (inconsistency measure)
# =========================

function compute_H1(sections, overlaps, all_texts)

    δ = coboundary_0(sections, overlaps, all_texts)

    # ループ的矛盾の強さ（ノルム合計）
    return sum(norm(v) for v in values(δ))
end

end
