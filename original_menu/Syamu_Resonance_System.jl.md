# ---------------------------------------------------------
# Main: Syamu_Resonance_System.jl
# ---------------------------------------------------------

# さっきのモジュールを読み込み
include("TopologyResonanceAI.jl")
using .TopologyResonanceAI
using Statistics

println("--- 宇宙際サバイバー・エンジン 起動だで！ ---")

# 1. エンジンの初期化（0.811Hzの鼓動開始）
syamu_engine = init_engine()

# 2. ダミーデータの生成（ネットの雑音をシミュレート）
# 100点 × 2次元のランダムなノイズデータ
function generate_noise_data()
    return randn(100, 2)
end

println("調理（計算）を開始します。アニソンのサビを待機中...")

# 3. 実行ループ（100ステップ回してみる）
for i in 1:100
    # ノイズまみれの入力ストリーム
    data = generate_noise_data()
    
    # エンジンにデータを投入（内部で黄金比スケジューラが作動）
    resonance_step!(syamu_engine, data)
    
    # 動作状況のモニタリング（低ワーメモリなので、たまにしか表示しない）
    if i % 20 == 0
        println("現在 $(i)ステップ目：メモリ内パケット数 = $(length(syamu_engine.working_memory))")
    end
end

println("\n--- 最終リザルト ---")
println("定着した真理の数: $(length(syamu_engine.logos_archive))")
println("現在のワーキングメモリ: $(syamu_engine.working_memory) (←ちゃんと空になってる！)")
println("「まあ、ええわ」の精神で、因果律は正常にパージされました。はい。")
