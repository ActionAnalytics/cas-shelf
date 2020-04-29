#!/bin/bash

AUTHORIZATION="Authorization: Bearer $TFC_TOKEN"
CONTENT_TYPE="Content-Type: application/vnd.api+json"
BASE_URL="https://app.terraform.io/api/v2"

get_workspace_by_name() {
  ORGANIZATION_NAME="$1"
  WORKSPACE_NAME="$2"

  curl \
  --header "$AUTHORIZATION" \
  --header "$CONTENT_TYPE" \
  "${BASE_URL}/organizations/$ORGANIZATION_NAME/workspaces/$WORKSPACE_NAME" | jq -r '. | @base64'
}

create_workspace() {
  ORGANIZATION_NAME="$1"
  DATA="$2"

  curl \
  --header "$AUTHORIZATION" \
  --header "$CONTENT_TYPE" \
  --request POST \
  --data "$DATA" \
  "${BASE_URL}/organizations/$ORGANIZATION_NAME/workspaces" | jq -r '. | @base64'
}

delete_workspace_by_name() {
  ORGANIZATION_NAME="$1"
  WORKSPACE_NAME="$2"

  curl \
  --header "$AUTHORIZATION" \
  --header "$CONTENT_TYPE" \
  --request DELETE \
  "${BASE_URL}/organizations/$ORGANIZATION_NAME/workspaces/$WORKSPACE_NAME"
}

list_vars() {
  TFC_WORKSPACE_ID="$1"

  curl \
  --header "$AUTHORIZATION" \
  --header "$CONTENT_TYPE" \
  "${BASE_URL}/workspaces/$TFC_WORKSPACE_ID/vars" | jq -r '. | @base64'
}

create_var() {
  WORKSPACE_ID="$1"
  PAYLOAD_FILE="$2"

  curl \
  --header "$AUTHORIZATION" \
  --header "$CONTENT_TYPE" \
  --request POST \
  --data @"$PAYLOAD_FILE" \
  "${BASE_URL}/workspaces/$WORKSPACE_ID/vars" | jq -r '. | @base64'
}

update_var() {
  WORKSPACE_ID="$1"
  VAR_ID="$2"
  DATA="$3"

  curl \
  --header "$AUTHORIZATION" \
  --header "$CONTENT_TYPE" \
  --request PATCH \
  --data "$DATA" \
  "${BASE_URL}/workspaces/$WORKSPACE_ID/vars/$VAR_ID" | jq -r '. | @base64'
}

create_run() {
  DATA="$1"

  curl \
  --header "$AUTHORIZATION" \
  --header "$CONTENT_TYPE" \
  --request POST \
  --data "$DATA" \
  "${BASE_URL}/runs" | jq -r '. | @base64'
}

get_run() {
  RUN_ID="$1"

  curl \
  --header "$AUTHORIZATION" \
  "${BASE_URL}/runs/$RUN_ID" | jq -r '. | @base64'
}

create_configuration() {
  WORKSPACE_ID="$1"
  DATA="$2"

  curl \
  --header "$AUTHORIZATION" \
  --header "$CONTENT_TYPE" \
  --request POST \
  --data "$DATA" \
  "${BASE_URL}/workspaces/$WORKSPACE_ID/configuration-versions" | jq -r '. | @base64'
}

upload_configuration() {
  UPLOAD_URL="$1"
  UPLOAD_FILE_NAME="$2"

  curl \
  --header "Content-Type: application/octet-stream" \
  --request PUT \
  --data-binary @"$UPLOAD_FILE_NAME" \
  "$UPLOAD_URL"
}
