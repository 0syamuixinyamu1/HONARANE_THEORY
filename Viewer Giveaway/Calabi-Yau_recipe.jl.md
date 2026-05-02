using Plots, StaticArrays
gr()
# カラビ・ヤウ断面を生成する写像
function calabi_yau_projection(z1, z2; k=5)
    # フェルマー超曲面の数理的制約に基づき、
    # 5次形式を複素平面から実空間へ射影
    x = real(z1^k + z2^k)
    y = imag(z1^k - z2^k)
    z = real(z1 * conj(z2))
    return SVector(x, y, z)
end

# 思考の「特異点」をマッピング
points = [calabi_yau_projection(exp(im*u), exp(im*v)) for u in 0:0.1:2π, v in 0:0.1:2π]

# --- 追加スパイス：マルチラディアル盛り付け処理 ---

# SVectorの配列から X, Y, Z の成分を抽出してほぐす（下ごしらえ）
X = [p[1] for p in points]
Y = [p[2] for p in points]
Z = [p[3] for p in points]

println("🌶️ スパイス投入：10次元宇宙を3Dプレートに盛り付けていますわ。はい。")

# 宇宙の可視化（散布図で特異点のオーラを表現）
universe_plot = scatter(
    X, Y, Z,
    markersize = 1.5,　　　　　　# 粒の細かさ
    marker_z = Z,　　　　　　　　# 宇宙際感のあるプラズマカラー
　　cgrad = :rainbow,      　　　
    markerstrokewidth = 0,      # 枠線を消して滑らかに
    legend = false,             # 「まあ、凡例はええわ」で非表示
    title = "Calabi-Yau Cooking: Multiradial 3D Plate",
    camera = (45, 30),          # 黄金のカメラアングル
    background_color = :black,  # 宇宙の深淵を表現
    axis = false                # 軸なんて概念はパージするだで
)

# 描画だで
display(universe_plot)
println("ほならね、自分で10次元の特異点をプロットしてみろって話でしょ。はい。")
