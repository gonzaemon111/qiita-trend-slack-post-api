require "qiita_trend"
require 'slack/incoming/webhooks'
require 'dotenv'
Dotenv.load

daily_trend = QiitaTrend::Trend.new

# Dailyのトレンドを全て取得する
# p daily_trend.items

# DailyのトレンドでNEWのものだけを取得する
# p daily_trend.new_items

slack = Slack::Incoming::Webhooks.new(ENV["SLACK_WEBHOOK_URL"], channel: "qiita_trend_api", username: "monkey_bot")

daily_trend.new_items.each do |item|
  array0 = item["created_at"].split("T")[0].split("-")
  array1 = item["created_at"].split("T")[1].split("Z")
  string_sentence = array0[0] + "/" + array0[1] + "/" + array0[2] + " " + array1[0]
  attachments = [
    {
      "title": item["title"],
      "title_link": item["article"],
      "author_name": item["user_name"],
      "author_icon": item["user_image"],
      "thumb_url": item["user_image"],
      "fields": [
          {
            "title": "投稿者",
            "value": item["user_name"],
            "short": "true"              
          },
          {
            "title": "投稿日",
            "value": string_sentence,
            "short": "true"
          },
          {
            "title": "いいね",
            "value": item["likes_count"],
            "short": "true"
          }
      ],
      "color": "#81FFFF"
    }
  ]
  slack.post "本日のQiitaのデイリーランキング", attachments: attachments
end
puts "--------------"
