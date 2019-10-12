require "qiita_trend"
daily_trend = QiitaTrend::Trend.new

# Dailyのトレンドを全て取得する
p daily_trend.items

# DailyのトレンドでNEWのものだけを取得する
p daily_trend.new_items
