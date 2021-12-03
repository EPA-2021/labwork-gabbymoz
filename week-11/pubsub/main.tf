provider "google" {
}

resource "google_pubsub_topic" "pubsub-topic" {
  name = "epa-topic-1"

  # A label is a key-value pair that helps you organize your Google Cloud resources. 
  # You can attach a label to each resource, then filter the resources based on their labels. 
  # Information about labels is forwarded to the billing system, so you can break down your billed charges by label.
  labels = {
    activity = "epa-labs"
  }
  # By default, a message that cannot be delivered within the maximum retention 
  # time of 7 days is deleted and is no longer accessible.
  # this is a shorter time period of 1 day 3 min 20 sec
  message_retention_duration = "86600s"

}


resource "google_pubsub_subscription" "pubsub-subs" {
  name = "epa-subs-1"
  # notice that here we use the topic name from
  # google_pubsub_topic.pubsub-topic declared above
  topic = google_pubsub_topic.pubsub-topic.name

  ack_deadline_seconds = 20
  
  # in order subscriber
  enable_message_ordering = true
  
  labels = {
    activity = "epa-labs"
  }
}

resource "google_pubsub_subscription" "pubsub-subs-2" {
  name = "epa-subs-2"
  # notice that here we use the topic name from
  # google_pubsub_topic.pubsub-topic declared above
  topic = google_pubsub_topic.pubsub-topic.name

  ack_deadline_seconds = 20

  labels = {
    activity = "epa-labs"
  }
    


}

resource "google_storage_bucket" "bucket" {
  name     = format("%s-%s", var.project_id, "cloud-functions-bucket")
  location = "eu"
}

resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.bucket.name
  source = "/home/gabbi_moz/labwork-gabbymoz/week11/public-epa/pubsub/gcf/index.zip"
}

resource "google_cloudfunctions_function" "function" {
  name        = "hello-pubsub"
  description = "Hello PubSub Function"
  runtime     = "nodejs14"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource = google_pubsub_topic.pubsub-topic.name
  }

  entry_point = "helloPubSub"
  
}



