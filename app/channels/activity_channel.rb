class ActivityChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "activity_channel"
  end
end
